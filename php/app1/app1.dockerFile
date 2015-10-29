FROM ubuntu:trusty

ENV WK /var/www/app1/

WORKDIR /$WK

RUN apt-get update && apt-get install -y php5-fpm php5-curl php5-mysql php5-mcrypt

RUN mkdir -p /var/log/php-app1/
RUN mkdir -p /$WK

COPY index.php /$WK/
COPY app1 /etc/nginx/sites-enabled/app1/

RUN sed -i "s/\/var\/run\/php5-fpm.sock/\/var\/run\/app1\/php5-fpm-app1.sock/g" /etc/php5/fpm/pool.d/www.conf

ENTRYPOINT  ["/usr/sbin/php5-fpm"]

CMD ["-F"]
