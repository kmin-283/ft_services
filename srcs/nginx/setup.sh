#!/bin/sh

mkdir -p /var/run/nginx

ssh-keygen -A
adduser --disabled-password kmin
echo "kmin:kmin" | chpasswd
/usr/sbin/sshd

nginx -g "daemon off;"
