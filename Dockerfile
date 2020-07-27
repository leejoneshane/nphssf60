FROM php:apache

ENV DB_HOST sciencemysql
ENV DB_USER root
ENV DB_PASSWORD yourpassword

WORKDIR /var/www/html
ADD docker-php-entrypoint /usr/local/bin
ADD index.html /var/www/html

RUN apt-get update \
    && apt-get install -y mariadb-client openssh-server sudo zlib1g-dev libfreetype6-dev libjpeg62-turbo-dev libpng-dev libssl-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd fileinfo mysqli ftp \
    && docker-php-ext-enable mysqli fileinfo gd ftp \
    && sed 's/#PasswordAuthentication yes/PasswordAuthentication yes/g' -i /etc/ssh/sshd_config \
    && sed 's/DirectoryIndex index.php index.html/DirectoryIndex index.html index.php/g' -i /etc/apache2/conf-enabled/docker-php.conf \
    && chmod 755 /usr/local/bin/docker-php-entrypoint \
    && mkdir -p /run/sshd \
    && echo "post_max_size = 100M\n upload_max_filesize = 100M\n max_file_uploads = 20\n" > /usr/local/etc/php/conf.d/upload.ini
    
EXPOSE 22 80
