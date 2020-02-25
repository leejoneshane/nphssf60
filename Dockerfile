FROM php:apache

ENV DB_HOST sciencemysql
ENV DB_USER root
ENV DB_PASSWORD yourpassword

ADD docker-php-entrypoint /usr/local/bin

RUN apt-get update \
    && apt-get install -y openssh-server sudo \
    && useradd -G sudo science -p ${DB_PASSWORD}
