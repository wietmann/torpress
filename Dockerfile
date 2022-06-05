FROM wordpress:6.0.0-php8.1-apache
MAINTAINER Dmitry Danilov <dima.danilov9867@gmail.com>

ARG MARIADB_VERSION='10.5'

ARG DEBIAN_FRONTEND=noninteractive

# RUN apt-get update && \
#     apt-get install -y tor supervisor && \
#     apt-get clean && rm -rf /var/lib/apt/lists/*

# Tor, Supervisor
RUN apt-get update && \
	apt-get install -y --no-install-recommends tor supervisor

# MariaDB
RUN apt-get update && apt-get install -y --no-install-recommends software-properties-common gnupg && \
	apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xF1656F24C74CD1D8 && \
	echo 'deb [arch=amd64,arm64,ppc64el] http://sfo1.mirrors.digitalocean.com/mariadb/repo/'${MARIADB_VERSION}'/debian bullseye main' > /etc/apt/sources.list.d/mariadb.list && \
	apt-get update && apt-get install -y --no-install-recommends mariadb-server gosu

# To be fixed
RUN mkdir /var/run/mysqld

COPY files/mariadb-entrypoint.sh /usr/local/bin/mariadb-entrypoint.sh
COPY files/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY files/torrc /etc/tor/torrc
ADD files/mytune.cnf /etc/mysql/mariadb.conf.d/99-mytune.cnf

VOLUME /var/www/html
VOLUME /var/lib/tor

EXPOSE 80
EXPOSE 3306

CMD ["/usr/bin/supervisord"]
