FROM debian:12

RUN apt-get update -y && apt install -y mariadb-server

WORKDIR /usr/local/bin

COPY ./conf/my.cnf /etc/mysql/
COPY ./toos/init.sh .

EXPOSE 3306

CMD ["init.sh"]
