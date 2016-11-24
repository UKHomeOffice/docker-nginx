FROM alpine:3.4

RUN apk upgrade --no-cache && \
    apk add --no-cache nginx bash && \
    install -d -g nginx -o nginx /run/nginx && \
    chown -R nginx:nginx /etc/nginx /var/log/nginx

COPY bin/run.sh /run.sh
COPY conf.d /etc/nginx/conf.d

USER nginx
ENTRYPOINT ["/run.sh"]
