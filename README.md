# docker-nginx
Minimal bare nginx docker image.

[![Build Status](https://drone.digital.homeoffice.gov.uk/api/badges/UKHomeOffice/docker-nginx/status.svg)](https://drone.digital.homeoffice.gov.uk/UKHomeOffice/docker-nginx)

### Configuration
Bare in mind, that this container does not run as root, so you won't be able to
bind to privileged ports.

There are two ways to pass nginx configuration.

#### Config block via env variable
Read in a config block preserving new lines, etc.

```
read -r -d '' NGINX_CONFIG <<'EOF'
worker_processes auto;
error_log /dev/stderr error;

events {
    worker_connections 1024;
}

http {
    sendfile            on;
    tcp_nopush          on;
    tcp_nodelay         on;
    keepalive_timeout   65;
    types_hash_max_size 2048;

    include             /etc/nginx/mime.types;
    default_type        application/octet-stream;

    server {
        listen       10080 default_server;
        server_name  _;
        access_log   /dev/stdout;

        location / {
            default_type text/plain;
            return 200 "Everything is OK.\n";
        }
    }
}
EOF
```

```
export NGINX_CONFIG
docker run -ti --rm -e NGINX_CONFIG quay.io/ukhomeofficedigital/nginx:latest
```

#### Config file via env variable
You can provide a config file inside a container instead.

```
docker run -ti --rm -e NGINX_CONFIG_FILE=/config/nginx.conf quay.io/ukhomeofficedigital/nginx:latest
```


### Extra Configs

Extra config snippets can be found in [conf.d](conf.d) directory. You can
include specific files or all by adding the following to the main `nginx.conf`
file:

```
include /etc/nginx/conf.d/logging.conf;

```

