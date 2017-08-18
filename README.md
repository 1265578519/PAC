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


Ubuntu 16.10 x64（默认密码admin123）:
-------
``` bash
url='https://raw.githubusercontent.com/1265578519/PAC/master/install-on-ubuntu.sh'
curl -sL $url | sudo bash -
```



CentOS 6.8 x64（推荐用此系统）:
-------
``` bash
url='https://raw.githubusercontent.com/1265578519/PAC/master/install-on-centos.sh'
curl -sL $url | sudo bash -
```

装完后记得reboot重启下服务器确保生效。

然后使用 [PAC](http://pac.itzmx.com/abc.pac) 右键另存为 PAC 文件后修改其中的server01.pac.itzmx.com为你的服务器IP即可。

转载注明出处：http://bbs.itzmx.com/thread-8815-1-1.html


推荐服务器：http://www.vultr.com/?ref=6813695
优惠码：OWNCLOUD SSDVPS
赠送的20刀期限30天，注意使用。
注意点击小尾巴，才能享受到优惠哦 


捐赠：http://pac.itzmx.com/donate/index.html