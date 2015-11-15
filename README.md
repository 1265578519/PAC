[PAC](http://pac.itzmx.com/)
=======
本项目主要介绍如何利用国外VPS搭建多协议代理服务。

GFW 封锁了 HTTP/Socks5 代理，HTTP 代理是关键词过滤，Socks5 代理则是封锁协议。不过某些特殊的低端口并没有这么处理，已知的有 21，25。

20端口已经被封杀，21端口目前会被限速400Kbps，换算后约合50KB/S，建议使用25端口，不限速。

[这里](http://pac.itzmx.com/) 提供了我在 [vultr](http://pac.itzmx.com/abc.pac) 上搭建的公共代理。


搭建代理服务器
==============
在 25 端口搭建 http/https 代理。


Ubuntu（需要一行一行复制安装）:
-------
apt-get -y install squid
curl https://raw.githubusercontent.com/1265578519/PAC/master/squid/ubuntu-squid.conf > /etc/squid3/squid.conf
mkdir -p /var/cache/squid
chmod -R 777 /var/cache/squid
service squid3 stop
squid3 -z
service squid3 restart




CentOS 6.7 x64（推荐用此系统）:
-------
setenforce 0
ulimit -n 1048576
echo "* soft nofile 1048576" >> /etc/security/limits.conf
echo "* hard nofile 1048576" >> /etc/security/limits.conf
echo "alias net-pf-10 off" >> /etc/modprobe.d/dist.conf
echo "alias ipv6 off" >> /etc/modprobe.d/dist.conf
killall sendmail
/etc/init.d/postfix stop
chkconfig --level 2345 postfix off
yum -y install squid wget
wget -O /etc/squid/squid.conf https://raw.githubusercontent.com/1265578519/PAC/master/squid/centos-squid.conf
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


装完后记得reboot重启下服务器确保生效。

然后使用 [PAC](http://pac.itzmx.com/abc.pac) 右键另存为 PAC 文件后修改其中的IP地址为你的服务器IP即可。

注意服务器DNS修改成8.8.8.8（配置文件目前强制指定了DNS，可以无需修改）：http://bbs.itzmx.com/thread-6353-1-1.html

搭配锐速，网页打开速度翻十倍，效果更加：http://bbs.itzmx.com/thread-7220-1-1.html

转载注明出处：http://bbs.itzmx.com/thread-8815-1-1.html


推荐服务器：http://www.vultr.com/?ref=6813695
优惠码：OWNCLOUD
赠送的20刀期限30天，注意使用。
注意点击小尾巴，才能享受到优惠哦 

Ubuntu 可以直接使用，centos 现在只需要清理系统防火墙规则即可使用。

捐赠：http://pac.itzmx.com/donate/index.html