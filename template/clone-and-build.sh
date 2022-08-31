#!/bin/sh

set -e -u

NEL=$RYZOM_ROOT/src/ryzom-core.git
if [ ! -d ${NEL}/.git ]; then
	echo "==== NEL ======="
	mkdir -p $NEL
	git clone --depth 1 --branch main/atys-live https://github.com/ryzom/ryzomcore.git $NEL
else
	echo "NEL directory ${NEL}/.git already exists."
fi

SERVER=$RYZOM_ROOT/src/ryzom-server.git
if [ ! -d ${SERVER}/.git ]; then
	echo "==== SERVER ===="
	mkdir -p $SERVER
	git clone --depth 1 --branch main/atys-live https://gitlab.com/ryzom/ryzom-server.git $SERVER
else
	echo "SERVER directory ${SERVER}/.git already exists"
fi

RAS=$RYZOM_ROOT/server/sbin/ryzom_admin_service
if [ ! -f ${RAS} ]; then
	echo "Compiling nel..."
	$RYZOM_ROOT/build.sh --core
	$RYZOM_ROOT/build.sh --server
else
	echo "
Server executable '${RAS}' already exists
To build nel or server, use
	${RYZOM_ROOT}/build.sh --core
	${RYZOM_ROOT}/build.sh --server
"
fi

