From longwuyuan/alpine

RUN apk add nginx php7-fpm

COPY supervisord.conf /etc/supervisord.conf

CMD /bin/sh /usr/bin/supervisord -n -c /etc/supervisord.conf
