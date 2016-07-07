FROM alpine:3.4

RUN apk upgrade --no-cache
RUN apk add --no-cache nginx bash

ADD bin/run.sh /run.sh

ENTRYPOINT ["/run.sh"]
