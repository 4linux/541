FROM alpine
EXPOSE 8080

ENV PHP_INI='/etc/php7/php.ini'
ENV DB_HOST=''
ENV DB_PORT=3306
ENV DB_USER=''
ENV DB_NAME=''
ENV DB_PASS=''

RUN apk add --no-cache php-cli php-mysqli php-session php7-pecl-memcached && mkdir /app

COPY . /app

WORKDIR /app
ENTRYPOINT ["sh", "-c", "php -c $PHP_INI -S 0.0.0.0:8080 -t /app"]
