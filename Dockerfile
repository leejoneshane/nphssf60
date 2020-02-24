FROM php:apache

ENV DB_HOST sciencemysql
ENV DB_USER root
ENV DB_PASSWORD scienceMeps

RUN apt-get update \
    && apt-get install -y openssh-server sudo \
    && useradd -G sudo science -p scienceMeps
    
CMD ["apache2-foreground"]   
