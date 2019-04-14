#!/bin/bash

docker image pull php:7.3.4-stretch
docker stop php-nginx 2>/dev/null
docker rm php-nginx 2>/dev/null
docker build -f Dockerfile-php-nginx -t php-nginx-image .
docker run -itd -p 9100:80 --name php-nginx -v "$PWD/README.md":/tmp/README.md php-nginx-image
docker ps
# curl http://localhost
# curl -k https://localhost
docker exec -it php-nginx bash
