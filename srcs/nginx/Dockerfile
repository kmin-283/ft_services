FROM alpine:latest
MAINTAINER kmin

RUN apk update && apk add --no-cache bash nginx openssh

COPY ./index.html /var/www/localhost/htdocs
COPY ./entry.sh /tmp/entry.sh
RUN chmod +x /tmp/entry.sh

EXPOSE 80 443 22

ENTRYPOINT ["/tmp/entry.sh"]