#
# Ryzom
#
#FROM debian:jessie
##libpng12-dev
FROM debian:buster
MAINTAINER Meelis Mägi <nimetu@gmail.com>

RUN apt-get update -y && apt-get install -y --no-install-recommends \
	autoconf \
	automake \
	build-essential \
	ca-certificates \
	cmake \
	curl \
	debhelper \
	gdb \
	git \
	less \
	libboost-filesystem1.67-dev \
	libboost-filesystem1.67.0 \
	libboost-system1.67-dev \
	libboost-system1.67.0 \
	libboost-thread1.67-dev \
	libboost-thread1.67.0 \
	libcurl4-openssl-dev \
	libexpat1-dev \
	libfreetype6-dev \
	libgif-dev \
	libgl1-mesa-dev \
	libjpeg62-turbo-dev \
	libluabind-dev \
	liblzma-dev \
	libmariadbclient-dev-compat \
	libopenal-dev \
	libpng-dev \
	libqt4-dev \
	libqt4-opengl-dev \
	libssl-dev \
	libtool \
	libvorbis-dev \
	libxml2-dev \
	libxrandr-dev \
	libxrender-dev \
	libxxf86vm-dev \
	lintian \
	ltrace \
	mariadb-client \
	mc \
	nano \
	net-tools \
	rrdtool \
	screen \
	strace \
	sudo \
	tcpdump \
	tmux \
	valgrind \
	vim \
	wget \
	xdelta \
	xsltproc \
	zlib1g-dev \
	&& apt-get clean && rm -rf /var/lib/apt/lists/*

COPY ./docker-entrypoint.sh /

# env variables for scripts
ENV RYZOM_ROOT=/srv/ryzom
ENV RYZOM_SCRIPTS="$RYZOM_ROOT/scripts"
ENV RYZOM_NEL_LIB="$RYZOM_ROOT/server/lib"
ENV LD_LIBRARY_PATH="$RYZOM_NEL_LIB"
ENV PATH="$RYZOM_ROOT/server/sbin:$RYZOM_ROOT/server/bin:$RYZOM_SCRIPTS:$PATH"

# run as root
RUN \
	# replace /bin/dash redirect
	rm /bin/sh && ln -s /bin/bash /bin/sh  && \
	# add new user 'ryzom' with password 'ryzom' and allow sudo access
	# new user is created with UID/GID=1000 which should match host user UID/GID
	useradd -ms /bin/bash ryzom && echo "ryzom:ryzom" | chpasswd && adduser ryzom sudo && \
	# create persistent volume using user credentials (not root:root)
	mkdir -p $RYZOM_ROOT && chown ryzom:ryzom -R $RYZOM_ROOT

# same as RYZOM_ROOT
VOLUME /srv/ryzom
WORKDIR /srv/ryzom

USER ryzom

RUN \
	# db host/pass is set from env
	echo -e "[client]\nuser=root\nhost=db\n" > $HOME/.my.cnf

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["batchstart"]

