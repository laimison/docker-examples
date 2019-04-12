#!/bin/bash

docker image pull php:7.3.4-apache-stretch
docker stop my-httpd 2>/dev/null
docker rm my-httpd 2>/dev/null
docker build -f Dockerfile -t my-httpd-image .
docker run -itd -p 9001:80 -p 9002:443 --name my-httpd -v "$PWD/html":/var/www/html -v "$PWD/php.ini":/usr/local/etc/php/php.ini -v "$PWD/default-ssl.conf":/etc/apache2/sites-available/default-ssl.conf -v "$PWD/000-default.conf":/etc/apache2/sites-available/000-default.conf -v "$PWD/ssl.conf":/etc/apache2/mods-available/ssl.conf my-httpd-image
docker ps
curl http://localhost:9001
curl -k https://localhost:9002
docker exec -it my-httpd bash
