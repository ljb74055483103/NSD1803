#!/bin/bash
read -p "请输入主机名：" name
hostnamectl set-hostname $name
rm -rf /etc/yum.repos.d/*
read -p "请输入yum源IP：" ip
echo "[aa]
name=bb
baseurl=ftp://$ip/rhel7
enabled=1
gpgcheck=0" > /etc/yum.repos.d/dvd.repo
echo "1" |passwd --stdin root 
yum -y install gcc pcre-devel openssl-devel mariadb mariadb-server mariadb-devel php php-mysql
tar -xf lnmp_soft.tar.gz
cd lnmp_soft/
yum -y install php-fpm-5.4.16-42.el7.x86_64.rpm
tar -xf nginx-1.12.2.tar.gz
cd nginx-1.12.2/
./configure --with-http_ssl_module --with-stream --with-http_stub_status_module
make && make install
cp /usr/local/nginx/sbin/nginx  /sbin/
systemctl restart php-fpm mariadb
systemctl enable php-fpm mariadb
