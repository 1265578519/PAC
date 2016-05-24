[PAC](http://pac.itzmx.com/)
=======
本项目主要介绍如何利用国外VPS搭建多协议代理服务。

GFW 封锁了 HTTP/Socks5 代理，HTTP 代理是关键词过滤，Socks5 代理则是封锁协议。不过某些特殊的低端口并没有这么处理，已知的有 21，25。

20端口已经被封杀，21端口目前会被限速400Kbps，换算后约合50KB/S，建议使用25端口，不限速。

[这里](http://pac.itzmx.com/) 提供了我在 [vultr](http://pac.itzmx.com/abc.pac) 上搭建的公共代理。

更新SQ防扫认证，登录信息为
帐号：root
密码：pac.itzmx.com


搭建代理服务器
==============
在 25 端口搭建 http/https 代理。


Ubuntu（需要一行一行复制安装）:
-------
``` markdown
apt-get -y install squid
curl http://github.itzmx.com/1265578519/PAC/master/squid/ubuntu-squid.conf > /etc/squid3/squid.conf
echo "root:W10fM8VWO04aM" >> /etc/squid/passwd
mkdir -p /var/cache/squid
chmod -R 777 /var/cache/squid
service squid3 stop
squid3 -z
service squid3 restart
```



CentOS 6.7 x64（推荐用此系统）:
-------
``` markdown
setenforce 0
ulimit -n 800000
echo "* soft nofile 800000" >> /etc/security/limits.conf
echo "* hard nofile 800000" >> /etc/security/limits.conf
echo "alias net-pf-10 off" >> /etc/modprobe.d/dist.conf
echo "alias ipv6 off" >> /etc/modprobe.d/dist.conf
killall sendmail
/etc/init.d/postfix stop
chkconfig --level 2345 postfix off
yum -y install squid wget
wget http://github.itzmx.com/1265578519/PAC/master/squid/centos-squid.conf -O /etc/squid/squid.conf
echo "root:W10fM8VWO04aM" >> /etc/squid/passwd
mkdir -p /var/cache/squid
chmod -R 777 /var/cache/squid
squid -z
service squid restart
chkconfig --level 2345 squid on
iptables -t nat -F
iptables -t nat -X
iptables -t nat -P PREROUTING ACCEPT
iptables -t nat -P POSTROUTING ACCEPT
iptables -t nat -P OUTPUT ACCEPT
iptables -t mangle -F
iptables -t mangle -X
iptables -t mangle -P PREROUTING ACCEPT
iptables -t mangle -P INPUT ACCEPT
iptables -t mangle -P FORWARD ACCEPT
iptables -t mangle -P OUTPUT ACCEPT
iptables -t mangle -P POSTROUTING ACCEPT
iptables -F
iptables -X
iptables -P FORWARD ACCEPT
iptables -P INPUT ACCEPT
iptables -P OUTPUT ACCEPT
iptables -t raw -F
iptables -t raw -X
iptables -t raw -P PREROUTING ACCEPT
iptables -t raw -P OUTPUT ACCEPT
service iptables save
```

装完后记得reboot重启下服务器确保生效。

然后使用 [PAC](http://pac.itzmx.com/abc.pac) 右键另存为 PAC 文件后修改其中的server01.pac.itzmx.com为你的服务器IP即可。

转载注明出处：http://bbs.itzmx.com/thread-8815-1-1.html


推荐服务器：http://www.vultr.com/?ref=6813695
优惠码：OWNCLOUD SSDVPS
赠送的20刀期限30天，注意使用。
注意点击小尾巴，才能享受到优惠哦 


捐赠：http://pac.itzmx.com/donate/index.html