#!/bin/bash

docker stop my-httpd 2>/dev/null
docker rm my-httpd 2>/dev/null
docker build -f Dockerfile -t my-httpd-image .
docker run -itd -p 80:80 -p 443:443 --name my-httpd -v "$PWD/html":/var/www/html -v "$PWD/php.ini":/usr/local/etc/php/php.ini -v "$PWD/default-ssl.conf":/etc/apache2/sites-available/default-ssl.conf -v "$PWD/000-default.conf":/etc/apache2/sites-available/000-default.conf -v "$PWD/ssl.conf":/etc/apache2/mods-available/ssl.conf my-httpd-image
docker ps
curl http://localhost
curl -k https://localhost
docker exec -it my-httpd bash
