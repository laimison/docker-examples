#!/bin/bash

containers=`docker-compose ps | awk '{print $1}' | tail -n +3`

containers_exec () {
  for c in $containers
  do
    docker exec -it $c bash
  done
}

case $1 in
  build)
    docker-compose down && docker-compose build && docker-compose up -d && docker-compose ps
    curl http://localhost
    ;;
  build-no-cache)
    docker-compose down && docker-compose build --no-cache && docker-compose up -d && docker-compose ps
    ;;
  exec)
    containers_exec
    ;;
  ps)
    docker-compose ps
    ;;
  logs)
    if echo $2 | grep -q [a-zA-Z]
    then
      container=$2
      printf "Printing logs for ${container}\n\n"
    else
      shuf=`which shuf gshuf`
      container=`echo $containers | tr ' ' '\n' | gshuf -n 1`
      printf "Randomly chosen to print logs for ${container}\n\n"
    fi

    docker logs -f $container
    ;;
  test_specific)
    docker image pull php:7.3.4-fpm-stretch
    docker stop php-nginx 2>/dev/null
    docker rm php-nginx 2>/dev/null
    docker build -f Dockerfile-php-nginx -t php-nginx-image .
    docker run -itd -p 9100:80 -h php-nginx --name php-nginx -v "$PWD/README.md":/tmp/README.md php-nginx-image
    # docker run -itd -p 9100:80 -h php-nginx --name php-nginx -v "$PWD/README.md":/tmp/README.md -v "$PWD/php-nginx/default.conf":/etc/nginx/conf.d/default.conf php-nginx-image
    docker ps
    docker exec -it php-nginx /bin/bash
    ;;
  *)
    echo 'Usage:
    build - down & build & up docker containers from Dockerfile
    build-no-cache - down & build --no-cache && up docker containers from Dockerfile
    exec - bash login to all containers one by one
    ps - list running docker containers
    logs - read logs
    test_specific - test specific container outside of docker-compose'
    ;;
esac
