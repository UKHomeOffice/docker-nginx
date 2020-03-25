#!/bin/bash
cleanup() {
  if docker ps -a --filter "name=nginx-test" | grep nginx-test &>/dev/null; then
    echo "Removing nginx-test container..."
    docker stop nginx-test &>/dev/null && docker rm nginx-test &>/dev/null
  else
    echo "No nginx-test container found."
  fi

  if docker images nginx-test-img | grep nginx-test-img &>/dev/null; then
    echo "Removing nginx-test-img image..."
    docker rmi nginx-test-img &>/dev/null
  else
    echo "No nginx-test-img image found."
  fi
}

docker build -t nginx-test-img -f Dockerfile-test .
docker run --name nginx-test -e NGINX_CONFIG_FILE=/nginx.conf -d nginx-test-img
sleep 3

for i in http stream ; do 
  echo "Curling $i server listener..."
  docker exec nginx-test sh nginx-test.sh $i
  if [[ $? -ne 0 ]]; then
    echo "ERROR: Failed curl on $i listener"
    cleanup
    exit 1
  else
    echo "Passed $i check"
  fi
done
cleanup
echo "Success!"
exit 0
