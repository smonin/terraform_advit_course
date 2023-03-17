#!/bin/bash
yum -y update
yum -y install httpd
ip=`curl icanhazip.com`
echo "<h1>Web Server with IP: $ip is ready!</h1>" > /var/www/html/index.html
sudo service httpd start
chkconfig httpd on