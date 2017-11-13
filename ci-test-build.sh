#!/bin/bash

# Runs a test nginx container

set -x

clean_up

# Build a new image and run a container with the new image
# this dockerfile has the nginx config file built into it
docker build -t nginx-test-image -f Dockerfile-test .
docker run --name nginx-test -e NGINX_CONFIG_FILE=/nginx.conf -d nginx-test-image

# debugging
docker ps -a --filter "name=nginx-test" --filter "status=exited" | grep nginx-test && docker logs nginx-test && exit 1 || echo "Container started..."

# Test the container/image
sleep 3
#apk update && apk add curl
curl -sf http://$$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' nginx-test):10080

clean_up

# Removes the test container and image
clean_up() {
  if docker ps -a --filter "name=nginx-test" | grep nginx-test &>/dev/null; then
    echo "Removing nginx-test container..."
    docker stop nginx-test && docker rm nginx-test &>/dev/null
  else
    echo "No nginx-test container found."
  fi

  if docker images nginx-test-image | grep nginx-test-image &>/dev/null; then
    echo "Removing nginx-test-image image..."
    docker rmi nginx-test-image
  else
    echo "No nginx-test-image image found."
  fi
}
