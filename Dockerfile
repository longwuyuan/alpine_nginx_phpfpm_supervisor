From longwuyuan/alpine

RUN apk add nginx \
    make \
    pcre-dev \
    pkgconf \
    re2c \
    libpng-dev \
    libjpeg-turbo-dev \
    freetype-dev \
    openssl-dev \
    libmcrypt-dev \
    librdkafka-dev \
    tar \
    xz \
    ca-certificates \
    php7 \
    php7-fpm \
    php7-mysqli \
    php7-mcrypt \
    php7-gd \
    php7-curl \
    php7-common \
    php7-json \
    php7-xml \
    php7-mbstring \
    php7-pdo_mysql \
    php7-zip && \
    mkdir -p /code /etc/supervisor.d /run/php /var/log/supervisor && \
    touch /var/log/php7/fpm_error.log && \
    rm -f /etc/nginx/nginx.conf /etc/nginx/conf.d/default.conf /etc/php7/php.ini /etc/php7/php-fpm.d/www.conf

# Copy our custom nginx & fpm config (scraped from current infrastructure but still lots to scrape)
COPY supervisor_nginx.ini /etc/supervisor.d/supervisor_nginx.ini
COPY supervisor_phpfpm.ini /etc/supervisor.d/supervisor_phpfpm.ini
COPY nginx.conf /etc/nginx/nginx.conf
COPY default.conf /etc/nginx/conf.d/default.conf
COPY site.conf /etc/nginx/conf.d/site.conf
COPY php.ini /etc/php7/php.ini
COPY www.conf /etc/php7/php-fpm.d/www.conf
COPY phptest.php /var/www/localhost/htdocs/phptest.php

EXPOSE 80

CMD /bin/sh /usr/bin/supervisord -n -c /etc/supervisord.conf
