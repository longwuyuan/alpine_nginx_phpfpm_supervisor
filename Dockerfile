From longwuyuan/alpine

RUN apk add bash \
    gettext \
    tzdata \
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
    php7-dom \
    php7-gettext \
    php7-fpm \
    php7-mysqlnd \
    php7-mysqli \
    php7-mcrypt \
    php7-gd \
    php7-curl \
    php7-common \
    php7-json \
    php7-xml \
    php7-mbstring \
    php7-pdo_mysql \
    php7-zip \
    php7-phar \
    php7-opcache \
    php7-openssl \
    php7-session \
    php7-zlib \
    nginx \
    supervisor && \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer && \
    ln -s /etc/php7 /etc/php && \
    ln -s /usr/bin/php7 /usr/bin/php && \
    ln -s /usr/sbin/php-fpm7 /usr/bin/php-fpm && \
    ln -s /usr/lib/php7 /usr/lib/php && \
    mkdir -p /code /etc/supervisor.d /run/php /var/log/supervisord && \
    touch /var/log/php7/fpm_error.log && \
    rm -f /etc/nginx/nginx.conf /etc/nginx/conf.d/default.conf /etc/php7/php.ini /etc/php7/php-fpm.d/www.conf /etc/supervisord.conf


# Copy our custom nginx & fpm config (scraped from current infrastructure but still lots to scrape)
COPY supervisord.conf /etc/supervisord.conf
COPY nginx.conf /etc/nginx/nginx.conf
COPY default.conf /etc/nginx/conf.d/default.conf
COPY site.conf /etc/nginx/conf.d/site.conf
COPY listener.php /listener.php
COPY php.ini /etc/php7/php.ini
COPY www.conf /etc/php7/php-fpm.d/www.conf
COPY phptest.php /var/www/localhost/htdocs/phptest.php

EXPOSE 80

CMD /bin/sh /usr/bin/supervisord -n -c /etc/supervisord.conf
