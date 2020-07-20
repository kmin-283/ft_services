FROM alpine:latest

RUN apk add --no-cache mysql mysql-client bash

COPY ./entry.sh /tmp/entry.sh
RUN chmod +x /tmp/entry.sh

EXPOSE 3306

ENTRYPOINT ["/tmp/entry.sh"]