#!/bin/bash

set -ueo pipefail

SELF=$(realpath $0)
DOCKYFLAG="./.docky-build-flag"

# CPU cores from docker-compose.yml
export MAKEFLAGS="-j${JOBS:-`nproc`}"

# directory for this script
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

if [ -z ${RYZOM_ROOT:-} ]; then
	RYZOM_ROOT=$DIR
fi

# FIXME: create paths relative this this script so this can also be used to compile client in host mode
# FIXME: must refuse to run install in host mode
# parent directory where 'src' is and where to install binaries

do_build(){
	# run 'make DESTDIR=.. install'
	DESTDIR=${1:-}

	# create directories
	install -d $BUILD_ROOT

	pushd $BUILD_ROOT

	# run cmake only when build.sh is newer than build flag
	if [ ! -f "$DOCKYFLAG" -o "$SELF" -nt "$DOCKYFLAG" ]; then
		cmake $CMAKE_OPTIONS -DCMAKE_INSTALL_PREFIX=/ $SOURCE || exit 1
		touch $DOCKYFLAG
	fi

	echo "Running 'make' in '$BUILD_ROOT'"
	make

	if [ ! -z "$DESTDIR" ]; then
		echo "Running 'make DESTDIR=$DESTDIR' install '$BUILD_ROOT'"
		make DESTDIR=$DESTDIR install
	fi

	popd
}

# sources directory
SOURCE=$RYZOM_ROOT/src/ryzom-core.git

case "${1:-}" in
	--server)
		BUILD_ROOT=$RYZOM_ROOT/src/build-core-static
		CMAKE_OPTIONS="
			-DBUILD_DOCUMENTATION=OFF
			-DCMAKE_BUILD_TYPE=Release
			-DFINAL_VERSION=OFF
			-DWITH_3D=ON
			-DWITH_DRIVER_OPENAL=OFF
			-DWITH_DRIVER_OPENGL=OFF
			-DWITH_GUI=OFF
			-DWITH_INSTALL_LIBRARIES=OFF
			-DWITH_MONGODB=OFF
			-DWITH_NEL_SAMPLES=OFF
			-DWITH_NEL_TESTS=OFF
			-DWITH_NEL_TOOLS=ON
			-DWITH_PCH=OFF
			-DWITH_RYZOM_CLIENT=OFF
			-DWITH_RYZOM_SERVER=ON
			-DWITH_RYZOM_TOOLS=ON
			-DWITH_SOUND=OFF
			-DWITH_STATIC=ON
			-DWITH_STATIC_DRIVERS=ON
			-DWITH_STATIC_EXTERNAL=OFF
			-DWITH_SYMBOLS=OFF
			-DWITH_UNIX_STRUCTURE=OFF
		"
		do_build $RYZOM_ROOT/server
		;;
	--client)
		CMAKE_OPTIONS="
			-DBUILD_DOCUMENTATION=OFF
			-DCMAKE_BUILD_TYPE=Release
			-DFINAL_VERSION=OFF
			-DWITH_MONGODB=OFF
			-DWITH_NEL_SAMPLES=OFF
			-DWITH_NEL_TESTS=OFF
			-DWITH_NEL_TOOLS=OFF
			-DWITH_RYZOM_CLIENT=ON
			-DWITH_RYZOM_SERVER=OFF
			-DWITH_RYZOM_TOOLS=OFF
			-DWITH_STATIC=ON
			-DWITH_STATIC_DRIVERS=ON
			-DWITH_STATIC_EXTERNAL=OFF
			-DWITH_SYMBOLS=ON
		"
		BUILD_ROOT=$RYZOM_ROOT/src/build-client-static
		do_build
		;;
	--database-plr)
		echo "Generate egs/database_plr.h"
		SOURCE=$RYZOM_ROOT/src/ryzom-core.git
		xsltproc --stringparam filename database --stringparam bank PLR --stringparam output header --stringparam side server \
			--output $SOURCE/ryzom/server/src/entities_game_service/database_plr.h \
					 $SOURCE/ryzom/common/src/game_share/generate_client_db.xslt \
					 $SOURCE/ryzom/common/data_common/database.xml
		xsltproc --stringparam filename database --stringparam bank PLR --stringparam output cpp --stringparam side server \
			--output $SOURCE/ryzom/server/src/entities_game_service/database_plr.cpp \
					 $SOURCE/ryzom/common/src/game_share/generate_client_db.xslt \
					 $SOURCE/ryzom/common/data_common/database.xml
		;;
	*)
		echo "$0 --server | --client | --database-plr"
		exit 1
		;;
esac

