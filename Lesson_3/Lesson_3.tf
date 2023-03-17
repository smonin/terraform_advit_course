provider "aws" {}

resource "aws_instance" "web_server" {
    ami = "ami-06616b7884ac98cdd"
    instance_type = "t2.micro"
    vpc_security_group_ids = [aws_security_group.web_server_sg.id]
    tags = {
        Name = "Simple Web server Instance by Terraform"
        Owner = "Stanislav Monin"
    }
    user_data = file("install_httpd.sh")

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

