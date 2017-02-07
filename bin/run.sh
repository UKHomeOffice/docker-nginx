#!/bin/bash -

set -o errexit

mkdir -p /run/nginx

# config file takes precedence
if [[ -f ${NGINX_CONFIG_FILE} ]]; then
  nginx -g 'daemon off;' -c ${NGINX_CONFIG_FILE}
elif [[ -n ${NGINX_CONFIG} ]]; then
  cp -f <(echo "${NGINX_CONFIG}") /etc/nginx/nginx.conf
  nginx -g 'daemon off;' -c /etc/nginx/nginx.conf
else
  echo "[error] please set NGINX_CONFIG_FILE or NGINX_CONFIG variable."
  exit 1
fi
