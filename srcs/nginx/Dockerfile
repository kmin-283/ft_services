FROM alpine:latest
MAINTAINER kmin

RUN apk update && apk add --no-cache bash nginx

COPY ./index.html /var/www/localhost/htdocs
COPY ./setup.sh /tmp/

EXPOSE 80 443

ENTRYPOINT ["/tmp/setup.sh"]