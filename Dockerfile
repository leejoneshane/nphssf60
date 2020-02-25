FROM php:apache

ENV DB_HOST sciencemysql
ENV DB_USER root
ENV DB_PASSWORD yourpassword

WORKDIR /var/www/html
ADD docker-php-entrypoint /usr/local/bin
ADD index.html /var/www/html

RUN apt-get update \
    && apt-get install -y openssh-server sudo \
    && sed 's/#PasswordAuthentication yes/PasswordAuthentication yes/g' -i /etc/ssh/sshd_config \
    && chmod 755 /usr/local/bin/docker-php-entrypoint \
    && mkdir -p /run/sshd
    
EXPOSE 22 80
