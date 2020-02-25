FROM php:apache

ENV DB_HOST sciencemysql
ENV DB_USER root
ENV DB_PASSWORD yourpassword

WORKDIR /var/www/html
ADD docker-php-entrypoint /usr/local/bin
ADD index.html /var/www/html

RUN apt-get update \
    && apt-get install -y openssh-server sudo \
    && useradd -G sudo science -p ${DB_PASSWORD} \
    && sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd \
    && chmod 755 /usr/local/bin/docker-php-entrypoint \
    && mkdir -p /run/sshd
    
EXPOSE 22 80
