FROM alpine:3.4

RUN apk upgrade --no-cache && apk add --no-cache nginx bash

COPY bin/run.sh /run.sh
COPY conf.d /etc/nginx/conf.d

ENTRYPOINT ["/run.sh"]
