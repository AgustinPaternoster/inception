FROM debian:12

RUN apt-get update -y \
	&& apt install -y mariadb-server gosu\
	&& rm -rf /var/lib/apt/lists/*

WORKDIR /usr/local/bin

COPY ./conf/my.cnf /etc/mysql/
COPY ./tools/init.sh /usr/local/bin/init.sh

RUN chmod +x /usr/local/bin/init.sh

EXPOSE 3306

ENTRYPOINT ["/usr/local/bin/init.sh"]
