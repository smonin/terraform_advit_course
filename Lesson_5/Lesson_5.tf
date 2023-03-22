provider "aws" {}

resource "aws_instance" "web_server" {
    ami = "ami-06616b7884ac98cdd"
    instance_type = "t2.micro"
    vpc_security_group_ids = [aws_security_group.web_server_sg.id]
    tags = {
        Name = "Simple Web server Instance by Terraform"
        Owner = "Stanislav Monin"
    }
    
    # Use "terraform console" command for t-shooting templates
    # FOR INSTANCE:
    # > templatefile("install_httpd.tpl", {web_server = "httpd", check_url ="icanhazip.com"}
    # OUTPUT:
    /* <<EOT
        #!/bin/bash
        yum -y update
        yum -y install httpd
        ip=`curl icanhazip.com`
        echo "<h1>Web Server with IP: $ip is ready!</h1>" > /var/www/html/index.html
        sudo service httpd start
        chkconfig httpd on
    EOT */

    user_data = templatefile("install_httpd.tpl", {
        web_server = "httpd",
        check_url = "icanhazip.com",
    })

}

resource "aws_security_group" "web_server_sg" {
    name = "allow_http"
    description = "Allow http inbound traffic"

    dynamic "ingress" {
        for_each = ["80", "443", "8080"]
        content {
            from_port = ingress.value
            to_port = ingress.value
            protocol = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
        }
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

