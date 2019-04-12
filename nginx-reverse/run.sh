#!/bin/bash

docker stop my-reverse
docker rm my-reverse
docker build -f Dockerfile -t my-reverse-image .
# docker run -itd -p 80:80 -p 443:443 --name my-reverse -v "$PWD/html":/var/www/html my-reverse-image
docker ps
# curl http://localhost
# curl -k https://localhost
docker exec -it my-reverse bash
