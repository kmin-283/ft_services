FROM alpine:latest

RUN apk update && apk add grafana --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --no-cache

RUN mkdir -p /etc/grafana

COPY ./srcs/provisioning/dashboards /usr/share/grafana/public/dashboards
COPY ./srcs/provisioning/datasources/influxdb-source.yaml /usr/share/grafana/conf/provisioning/datasources/influxdb-source.yaml
COPY ./srcs/provisioning/dashboards/dashboards.yaml /usr/share/grafana/conf/provisioning/dashboards/dashboards.yaml

EXPOSE 3000

ENTRYPOINT ["/usr/sbin/grafana-server","--config=/usr/share/grafana/conf/custom.ini","--homepath=/usr/share/grafana"]