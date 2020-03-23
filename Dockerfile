FROM alpine:3.11

RUN apk upgrade --no-cache && \
    apk add --no-cache nginx bash nginx-mod-http-lua nginx-mod-stream && \
    install -d -g nginx -o nginx /run/nginx && \
    chown -R nginx:nginx /etc/nginx /var/log/nginx

COPY bin/run.sh /run.sh
COPY conf.d /etc/nginx/conf.d

# UID for nginx user
USER 100

ENTRYPOINT ["/run.sh"]
