FROM alpine:latest

RUN apk upgrade && apk add openssl vsftpd

COPY ./entry.sh /tmp/entry.sh
RUN chmod 777 /tmp/entry.sh

EXPOSE 20 21 20000-20001

ENTRYPOINT ["/tmp/entry.sh"]