FROM debian:12

RUN apt-get update && apt-get install -y \
    nginx \
    openssl \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /etc/nginx/certs /var/www/html /run/nginx

COPY conf/default.conf /etc/nginx/conf.d/default.conf
COPY conf/san.cnf /etc/nginx/certs/san.cnf

RUN openssl genpkey -algorithm RSA -out /etc/nginx/certs/apaterno.42.fr.key && \
    openssl req -x509 -days 365 \
        -key /etc/nginx/certs/apaterno.42.fr.key \
        -out /etc/nginx/certs/apaterno.42.fr.crt \
        -config /etc/nginx/certs/san.cnf && \
    chmod 600 /etc/nginx/certs/apaterno.42.fr.key

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]

