FROM alpine
MAINTAINER kmin

RUN apk update
RUN apk add influxdb
RUN apk add bash
RUN apk add telegraf --update-cache --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted

RUN mkdir -p /etc/telegraf
RUN mkdir -p /etc/influxdb
COPY ./telegraf.conf /etc/telegraf/telegraf.conf

COPY ./start.sh /start.sh
RUN chmod +x /start.sh
EXPOSE 8086
CMD ./start.shg