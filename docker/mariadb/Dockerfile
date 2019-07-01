
FROM mariadb:10.2

VOLUME /var/lib/mysql
VOLUME /var/log/mysql

# all files/volumes mounted into container must exist on host side
# and owned by this uid/gid (1000:1000 on debian/ubuntu)
RUN useradd -ms /bin/bash ryzom && \
	echo "ryzom:ryzom" | chpasswd && \
	adduser ryzom sudo && \
	touch /etc/mysql/conf.d/99-custom.cnf && \
	chown ryzom.ryzom /etc/mysql/conf.d/99-custom.cnf

USER ryzom

