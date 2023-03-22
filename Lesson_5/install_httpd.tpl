#!/bin/bash
yum -y update
yum -y install ${web_server}
ip=`curl ${check_url}`
echo "<h1>Web Server with IP: $ip is ready!</h1>" > /var/www/html/index.html
sudo service ${web_server} start
chkconfig httpd on