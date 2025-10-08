FROM debian:12

RUN apt-get update && apt install -y\
	wget \
        php\
        php-fpm \
        php-mysqli \
        php-gd \
       	php-curl \
	php-mbstring \
        php-xml \
        php-zip

RUN mkdir -p /var/www/html

RUN wget  https://wordpress.org/latest.tar.gz -O /tmp/wordpress.tar.gz \
	&& tar -xzf /tmp/wordpress.tar.gz -C /var/www/html --strip-components=1\
	&& rm /tmp/wordpress.tar.gz

RUN chown -R www-data:www-data /var/www/html

WORKDIR /usr/local/bin

COPY ./conf/www.conf /etc/php/8.2/fpm/pool.d
COPY ./tools/init.sh .

RUN chmod +x ./init.sh

EXPOSE 9000

CMD ["./init.sh"]




	
