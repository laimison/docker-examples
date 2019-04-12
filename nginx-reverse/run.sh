#!/bin/bash

docker image pull nginx:1.15.11
docker stop my-reverse 2>/dev/null
docker rm my-reverse 2>/dev/null
docker build -f Dockerfile -t my-reverse-image .
docker run -itd -p 80:80 -p 443:443 --name my-reverse -v "$PWD/html":/usr/share/nginx/html my-reverse-image
docker ps
# curl http://localhost
# curl -k https://localhost
docker exec -it my-reverse bash
