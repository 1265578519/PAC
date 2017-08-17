#!/bin/bash

apt-get -y install squid
curl http://github.itzmx.com/1265578519/PAC/master/squid/ubuntu-squid.conf > /etc/squid/squid.conf
echo "root:ssbiY3prCJLxU" >> /etc/squid/passwd
mkdir -p /var/cache/squid
chmod -R 777 /var/cache/squid
service squid stop
squid -z
service squid restart
