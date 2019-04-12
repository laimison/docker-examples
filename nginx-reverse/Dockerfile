# https://hub.docker.com/_/php
FROM php:7.3.4-apache-stretch

RUN apt update && apt install -y lsof vim
RUN mkdir -p /etc/ssl/certs /etc/ssl/private

RUN openssl req -subj '/CN=example.com/O=Example Company/C=UK' -new -newkey rsa:2048 -sha256 -days 3650 -nodes -x509 -keyout /tmp/server.key -out /tmp/server.crt
RUN cd /tmp && cat server.crt server.key > server.pem
RUN cd /etc/apache2/sites-enabled && ln -sf ../sites-available/default-ssl.conf default-ssl.conf

RUN cp /tmp/server.pem /etc/ssl/certs/ssl-cert-snakeoil.pem
RUN cp /tmp/server.key /etc/ssl/private/ssl-cert-snakeoil.key

RUN cd /etc/apache2/mods-enabled && ln -sf ../mods-available/ssl.conf ssl.conf
RUN cd /etc/apache2/mods-enabled && ln -sf ../mods-available/ssl.load ssl.load
