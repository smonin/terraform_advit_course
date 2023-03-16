provider "aws" {}

resource "aws_instance" "web_server" {
    ami = "ami-06616b7884ac98cdd"
    instance_type = "t2.micro"
    vpc_security_group_ids = [aws_security_group.web_server_sg.id]
    tags = {
        Name = "Simple Web server Instance by Terraform"
        Owner = "Stanislav Monin"
    }
    user_data = <<EOF
#!/bin/bash
yum -y update
yum -y install httpd
ip=`curl icanhazip.com`
echo "<h1>Web Server with IP: $ip is ready!</h1>" > /var/www/html/index.html
sudo service httpd start
chkconfig httpd on   
EOF

}

resource "aws_security_group" "web_server_sg" {
    name = "allow_http"
    description = "Allow http inbound traffic"

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

