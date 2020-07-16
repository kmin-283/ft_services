FROM alpine:latest

RUN apk update && apk add grafana --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --no-cache

RUN mkdir -p /etc/grafana

EXPOSE 3000

ENTRYPOINT ["/usr/sbin/grafana-server","--config=/etc/grafana/grafana.ini","--homepath=/usr/share/grafana"]