#!/bin/bash

while true; do
	
  # https://docs.docker.com/engine/reference/commandline/image_prune/
  docker system prune --all --force
  docker system prune -a
  docker volume ls -f dangling=true
  docker volume prune
  docker image prune --filter="label=deprecated"

  # DOCKER_CLEAN_INTERVAL defaults to 30min
  sleep $DOCKER_CLEAN_INTERVAL
done
