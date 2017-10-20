#!/bin/bash

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
