#!/bin/bash

set -ueo pipefail

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

	# TODO: WITH_STATIC_EXTERNAL should be configurable from command line
	#       currently lua fails to compile with static external enabled
	if [ $USE_STATIC_LIBS = true ]; then
		CMAKE_OPTIONS="$CMAKE_OPTIONS -DWITH_STATIC=ON -DWITH_STATIC_DRIVERS=ON -DWITH_STATIC_EXTERNAL=OFF"
	else
		CMAKE_OPTIONS="$CMAKE_OPTIONS -DWITH_STATIC=OFF -DWITH_STATIC_DRIVERS=OFF -DWITH_STATIC_EXTERNAL=OFF"
	fi

	# run cmake only when build.sh is newer than cmake cache (ie, options changed)
	if [ ! -f './CMakeCache.txt' -o "$0" -nt './CMakeCache.txt' ]; then
		cmake $CMAKE_OPTIONS -DCMAKE_INSTALL_PREFIX=/ $SOURCE || exit 1
	fi

	echo "Running 'make' in '$BUILD_ROOT'"
	make

	if [ ! -z "$DESTDIR" ]; then
		echo "Running 'make DESTDIR=$DESTDIR' install '$BUILD_ROOT'"
		make DESTDIR=$DESTDIR install
	fi

	popd
}

# server install directory
NEL_DIR=$RYZOM_ROOT/server

# command line build options
BUILD_NEL=false
BUILD_SERVER=false
ENABLE_STATIC=false
ENABLE_SHARED=false
BUILD_CORE=false
BUILD_CLIENT=false

# internal
USE_STATIC_LIBS=true

while [ $# -gt 0 ]; do
	case "${1:-}" in
	--nel)
		BUILD_NEL=true
		;;
	--server)
		BUILD_SERVER=true
		;;
	--shared)
		ENABLE_SHARED=true
		;;
	--static)
		ENABLE_STATIC=true
		;;
	--core)
		BUILD_CORE=true
		;;
	--client)
		if grep -Eq '/(lxc|docker)/[[:xdigit:]]{64}' /proc/1/cgroup ; then
			echo "Compiling client inside container not supported"
			echo "FXIME: client needs all support libs as static"
			exit 1
		fi
		BUILD_CLIENT=true
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
		exit
		;;
	esac

	shift
done

# build static as default
if [ $ENABLE_SHARED = false ] && [ $ENABLE_STATIC = false ]; then
	ENABLE_STATIC=true
fi

if [ $BUILD_CORE = false ] && [ $BUILD_CLIENT = false ] && [ $BUILD_NEL = false ] && [ $BUILD_SERVER = false ]; then
	echo "$0 --nel --server"
	exit 1
fi

if [ $BUILD_CORE = true ]; then
	CMAKE_OPTIONS="
	-DCMAKE_BUILD_TYPE=Release
	-DFINAL_VERSION=OFF
	-DBUILD_DOCUMENTATION=OFF
	-DWITH_NEL=ON
	-DWITH_NEL_SAMPLES=OFF
	-DWITH_NEL_TESTS=OFF
	-DWITH_NEL_TOOLS=OFF
	-DWITH_RYZOM_SERVER=ON
	-DWITH_RYZOM_CLIENT=OFF
	-DWITH_STLPORT=OFF
	-DWITH_SYMBOLS=ON
	"

	SOURCE=$RYZOM_ROOT/src/ryzom-core.git
	if [ $ENABLE_STATIC = true ]; then
		BUILD_ROOT=$RYZOM_ROOT/src/build-core-static
		USE_STATIC_LIBS=true
		do_build $NEL_DIR
	fi

	if [ $ENABLE_SHARED = true ]; then
		BUILD_ROOT=$RYZOM_ROOT/src/build-core-shared
		USE_STATIC_LIBS=false
		do_build $NEL_DIR
	fi
fi

if [ ${BUILD_CLIENT} = true ]; then
	CMAKE_OPTIONS="
	-DCMAKE_BUILD_TYPE=Release
	-DFINAL_VERSION=OFF
	-DBUILD_DOCUMENTATION=OFF
	-DWITH_NEL=ON
	-DWITH_NEL_SAMPLES=OFF
	-DWITH_NEL_TESTS=OFF
	-DWITH_NEL_TOOLS=OFF
	-DWITH_RYZOM_CLIENT=ON
	-DWITH_RYZOM_SERVER=OFF
	-DWITH_STLPORT=OFF
	-DWITH_SYMBOLS=ON
	"
	SOURCE=$RYZOM_ROOT/src/ryzom-core.git
	BUILD_ROOT=$RYZOM_ROOT/src/build-client-static
	USE_STATIC_LIBS=true
	do_build
fi

# no --nel, --server not supported for now
exit

if [ "${BUILD_NEL}" = true ]; then
	CMAKE_OPTIONS="
	-DCMAKE_BUILD_TYPE=Release
	-DFINAL_VERSION=OFF
	-DBUILD_DOCUMENTATION=OFF
	-DWITH_3D=ON
	-DWITH_DRIVER_OPENGL=OFF
	-DWITH_DRIVER_OPENGLES=OFF
	-DWITH_GUI=OFF
	-DWITH_NEL=ON
	-DWITH_NELNS=OFF
	-DWITH_NEL_SAMPLES=OFF
	-DWITH_NEL_TESTS=OFF
	-DWITH_NEL_TOOLS=ON
	-DWITH_QT=ON
	-DWITH_RYZOM_CLIENT=OFF
	-DWITH_RYZOM_SERVER=OFF
	-DWITH_RYZOM_TOOLS=OFF
	-DWITH_SOUND=OFF
	-DWITH_STLPORT=OFF
	-DWITH_SYMBOLS=OFF
	"
	USE_STATIC_LIBS=false
	SOURCE=$RYZOM_ROOT/src/ryzom-core.git
	BUILD_ROOT=$RYZOM_ROOT/src/build-nel
	echo "Compiling nel"

	do_build $NEL_DIR
fi

#live server
# TODO: -DWITH_STATIC=ON ?? for live server
if [ "${BUILD_SERVER}" = true ]; then
	CMAKE_OPTIONS="
	-DCMAKE_BUILD_TYPE=Release \
	-DWITH_RYZOM_SERVER=ON \
	-DWITH_RYZOM_TOOLS=OFF \
	-DWITH_RYZOM_CLIENT=OFF \
	-DWITH_NEL_TESTS=OFF \
	-DWITH_NEL_TOOLS=OFF \
	-DWITH_NEL_SAMPLES=OFF \
	-DWITH_UNIX_STRUCTURE=OFF \
	-DWITH_INSTALL_LIBRARIES=OFF \
	-DWITH_DRIVER_OPENGL=OFF \
	-DWITH_DRIVER_OPENAL=OFF \
	-DWITH_PCH=OFF \
	-DWITH_STATIC=ON \
	-DWITH_GUI=OFF \
	-DWITH_3D=OFF \
	-DWITH_SOUND=OFF \
	-DCMAKE_CXX_FLGAS=\"-DHAVE_MONGO \${CMAKE_CXX_FLAGS}\"
	-DNEL_DIR=$NEL_DIR
	"
	SOURCE=$RYZOM_ROOT/src/ryzom-server.git
	BUILD_ROOT=$RYZOM_ROOT/src/build-server
	USE_STATIC_LIBS=false
	echo "Compiling server"
	do_build $NEL_DIR
fi
