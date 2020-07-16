FROM alpine:latest

RUN apk update && apk add telegraf --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing/

RUN mkdir -p /etc/telegraf

ENTRYPOINT ["/usr/bin/telegraf"]