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
  *)
    echo 'Usage:
    build - down & build & up docker containers from Dockerfile
    build-no-cache - down & build --no-cache && up docker containers from Dockerfile
    exec - bash login to all containers one by one
    ps - list running docker containers
    logs - read logs'
    ;;
esac
