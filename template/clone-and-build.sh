#!/bin/sh

set -e -u

REPO=https://gitlab.com/ryzom/ryzom-core.git
BRANCH=main/atys-live

DESTDIR=$RYZOM_ROOT/src/ryzom-core.git
if [ ! -d ${NEL}/.git ]; then
	echo "==== clone $REPO"
	mkdir -p $NEL
	git clone --depth 1 --branch $BRANCH $REPO $DESTDIR
else
	echo "Sources directory ${DESTDIR}/.git already exists."
fi

RAS=$RYZOM_ROOT/server/sbin/ryzom_admin_service
if [ ! -f ${RAS} ]; then
	echo "Compiling server..."
	$RYZOM_ROOT/build.sh --server
else
	echo "
Server executable '${RAS}' already exists
To re-build server, use
	${RYZOM_ROOT}/build.sh --server
"
fi

