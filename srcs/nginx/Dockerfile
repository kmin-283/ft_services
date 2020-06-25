FROM alpine

RUN apk update
RUN apk add openssh
RUN apk add openssl
RUN apk add nginx
# https://wiki.alpinelinux.org/wiki/Alpine_Linux_package_management(Add packages)
RUN apk add telegraf --update-cache --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted

# 유저 생성
RUN adduser -D -g 'www' www

# 디렉토리와 권한 설정
RUN mkdir /www
RUN chown -R www:www /var/lib/nginx
RUN chown -R www:www /www
RUN mkdir -p /run/nginx

# nginx.conf, 기본 html파일 복사
COPY ./nginx.conf /etc/nginx/nginx.conf
COPY ./index.html /www/

# ssh, ssl키 생성
RUN adduser -D user
RUN echo "user:password" | chpasswd
RUN ssh-keygen -A
RUN yes "" | openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/certs/localhost.key -out /etc/ssl/certs/localhost.crt

# Telegraf
RUN mkdir -p /etc/telegraf
#COPY ./telegraf.conf /etc/telegraf/telegraf.conf --> telegraf 서비스의 이름으로 변경해줘야 함

# We customize the SSH welcome message
RUN echo 'SSH of kmin' > /etc/motd

#COPY start.sh ./start.sh
#RUN chmod +x /start.sh
#CMD sh ./start.sh
EXPOSE 80
EXPOSE 443
EXPOSE 22