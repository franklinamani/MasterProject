FROM php:8.1-apache

RUN docker-php-ext-install mysqli && \
    docker-php-ext-install pdo pdo_mysql

RUN apt-get update && \
    apt-get install --no-install-recommends -y \
      rsync \
      inotify-tools && \
    rm -fR /var/lib/apt/lists/*

COPY kingsCS-filesync.sh /usr/local/bin/
COPY kingsCS-entrypoint.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/kingsCS-entrypoint.sh && \
    chmod +x /usr/local/bin/kingsCS-filesync.sh && \
    mkdir /html && \
    mkdir /var/www/sql && \
    ln -sf usr/local/bin/kingsCS-entrypoint.sh /entrypoint.sh

ENTRYPOINT ["kingsCS-entrypoint.sh"]

EXPOSE 80
STOPSIGNAL SIGWINCH

WORKDIR /var/www/html
CMD ["apache2-foreground"]
