FROM debian:12

RUN apt-get update -y\
	&& apt install -y nginx

WORKDIR /usr/local/bin

COPY ./tools/index.html /var/www/html/ 

EXPOSE 80

ENTRYPOINT ["nginx", "-g", "daemon off;"]



