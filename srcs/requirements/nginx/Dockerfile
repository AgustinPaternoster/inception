FROM debian:12

RUN apt-get update -y\
	&& apt install -y nginx openssl

RUN mkdir /etc/nginx/certs/

COPY ./conf/san.cnf /etc/nginx/certs/

RUN openssl genpkey -algorithm RSA -out /etc/nginx/certs/apaterno.42.fr.key
RUN openssl req -x509 -days 365 \ 
		-key /etc/nginx/certs/apaterno.42.fr.key \
		-out /etc/nginx/certs/apaterno.42.fr.crt \ 
		-config /etc/nginx/certs/san.cnf
RUN chmod 600 /etc/nginx/certs/apaterno.42.fr.key

WORKDIR /usr/local/bin

COPY ./tools/index.html /var/www/html/ 
COPY ./conf/apaterno.42.fr.conf /etc/nginx/conf.d/

EXPOSE 443

ENTRYPOINT ["nginx", "-g", "daemon off;"]



