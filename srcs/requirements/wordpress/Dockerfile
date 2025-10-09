FROM debian:12

RUN apt-get update && apt-get install -y \
    php-fpm \
    php-mysqli \
    php-curl \
    php-json \
    php-xml \
    php-gd \
    php-mbstring \
    wget \
    curl \
    mariadb-client \
   && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/www/html /run/php

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

COPY ./conf/www.conf /etc/php/8.2/fpm/pool.d
COPY tools/setup_wordpress.sh /usr/local/bin/setup_wordpress.sh
RUN chmod +x /usr/local/bin/setup_wordpress.sh

WORKDIR /var/www/html

EXPOSE 9000

ENTRYPOINT ["/usr/local/bin/setup_wordpress.sh"]



	
