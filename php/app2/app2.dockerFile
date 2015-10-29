FROM ubuntu:trusty

ENV WK /var/www/app2/

WORKDIR /$WK

RUN apt-get update && apt-get install -y php5-fpm php5-curl php5-mysql php5-mcrypt

RUN mkdir -p /var/log/php-fpm/
RUN mkdir -p /$WK

COPY index.php /$WK/
COPY app2 /etc/nginx/sites-enabled/app2/

RUN sed -i "s/\/var\/run\/php5-fpm.sock/\/var\/run\/app2\/php5-fpm-app2.sock/g" /etc/php5/fpm/pool.d/www.conf

ENTRYPOINT  ["/usr/sbin/php5-fpm"]

CMD ["-F"]
