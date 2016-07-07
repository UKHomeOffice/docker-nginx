# docker-nginx
Minimal bare nginx docker image


### Configuration
There are two ways to pass nginx configuration.

#### Config block via env variable
Read in a config block preserving new lines, etc.

```
read -r -d '' NGINX_CONFIG <<'EOF'
user nginx;
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
        listen       80 default_server;
        server_name  _;

        location / {
            return 200 "Everything is OK.\n";
        }
    }
}
EOF
```

```
export NGINX_CONFIG
docker run -ti --rm -e NGINX_CONFIG quay.io/ukhomeofficedigital/nginx:v0.0.1 
```

#### Config file via env variable
You can provide a config file inside a container instead.

```
docker run -ti --rm -e NGINX_CONFIG_FILE=/config/nginx.conf quay.io/ukhomeofficedigital/nginx:v0.0.1 
```


### Extra Configs

TODO
