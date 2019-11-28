#!/bin/sh

set -eu

CERT_DIR=/etc/nginx/certs

BITS=2048
DAYS=18250
SUBJ="/C=US/ST=DockyST/L=DockyL/O=DockyO/OU=DockyOU"

ROOT_KEY=$CERT_DIR/docky-root.key
ROOT_CRT=$CERT_DIR/docky-root.crt
ISSUER_KEY=$CERT_DIR/docky-issuer.key
ISSUER_CRT=$CERT_DIR/docky-issuer.crt
SERVER_KEY=$CERT_DIR/server.key
SERVER_CRT=$CERT_DIR/server.crt
BUNDLE_PEM=$CERT_DIR/server.pem

##############################################################################
if [ -z "${DOMAINS:-}" ]; then
	echo "No domains in DOMAINS env variable. Automatic certificates are disabled."
elif [ "${1:-}" == "nginx" ]; then
	echo "Checking certificates for '${DOMAINS}'"

	###########################################################################
	if [ ! -f $ROOT_KEY ]; then
		rm $ROOT_CRT || true
	fi
	if [ ! -f $ISSUER_KEY ]; then
		rm $ISSUER_CRT || true
	fi
	if [ ! -f $SERVER_KEY ]; then
		rm $SERVER_CRT || true
	fi
	###########################################################################
	# Root CA certs
	if [ ! -f $ROOT_CRT ]; then
		echo "Root certs"
		rm -f $ISSUER_CRT || true

		openssl genrsa -out $ROOT_KEY $BITS
		openssl req -new -key $ROOT_KEY -out /tmp/ca.csr -subj "$SUBJ/CN=Docky Root CA"
		openssl req -x509 -key $ROOT_KEY -in /tmp/ca.csr -out $ROOT_CRT -days $DAYS
	fi

	###########################################################################
	# Issuer certs
	if [ ! -f $ISSUER_CRT ]; then
		echo "Issuer certs"
		rm -f $SERVER_CRT || true

		echo -e "basicConstraints = critical,CA:true\nkeyUsage = critical,keyCertSign" > /tmp/issuer.ext
		openssl genrsa -out $ISSUER_KEY $BITS
		openssl req -new -key $ISSUER_KEY -out /tmp/issuer.csr -subj "$SUBJ/CN=Docky Issuer CA"
		openssl x509 -req -CA $ROOT_CRT -CAkey $ROOT_KEY -in /tmp/issuer.csr -out $ISSUER_CRT \
			-CAcreateserial -extfile /tmp/issuer.ext -days $DAYS
	fi

	###########################################################################
	# Web certs
	CURRENT_DOMAINS=""
	if [ -f $SERVER_CRT ]; then
		CURRENT_DOMAINS=$(openssl x509 -noout -in $SERVER_CRT  -text | grep "DNS" | tr -d "[:blank:]")
	fi

	ALT_NAME=""
	for d in $DOMAINS; do
		if [ ! -z "$ALT_NAME" ]; then
			ALT_NAME="${ALT_NAME},"
		fi
		ALT_NAME="${ALT_NAME}DNS:$d"
	done

	if [ "$ALT_NAME" != "$CURRENT_DOMAINS" ]; then
		echo "DOMAINS has changed, recreating server certs"
		rm -f $SERVER_CRT || true
	fi

	if [ ! -f $SERVER_CRT ]; then
		rm -f $BUNDLE_PEM || true

		echo "Server certs for domains '$DOMAINS'"
		openssl genrsa -out $SERVER_KEY $BITS
		openssl req -new -key $SERVER_KEY -out /tmp/server.csr -subj "$SUBJ/CN=localhost"
		# $DOMAINS can have space separated domains to include
		echo "extendedKeyUsage = serverAuth,clientAuth" > /tmp/server.ext
		echo "subjectAltName= ${ALT_NAME}" >> /tmp/server.ext

		openssl x509 -req -CA $ISSUER_CRT -CAkey $ISSUER_KEY -in /tmp/server.csr -out $SERVER_CRT \
			-CAcreateserial -extfile /tmp/server.ext -days $DAYS
	fi

	###########################################################################
	# server + issuer public keys as single file
	if [ ! -f $BUNDLE_PEM ]; then
		echo "Create certificate bundle for nginx"
		cat $SERVER_CRT $ISSUER_CRT > $BUNDLE_PEM
	fi
fi

#
echo "Running '$@'"
exec "$@"

