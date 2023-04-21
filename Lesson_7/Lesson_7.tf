provider "aws" {}

resource "aws_instance" "test_web_server" {
    ami = "ami-06616b7884ac98cdd"
    instance_type = "t2.micro"
    vpc_security_group_ids = [aws_security_group.test_web_server_sg.id]
    tags = {
        Name = "Test Web Server"
        Owner = "Stanislav Monin"
    }
    depends_on = [
      aws_instance.db_server, aws_instance.prod_web_server
    ]
}

resource "aws_instance" "prod_web_server" {
    ami = "ami-06616b7884ac98cdd"
    instance_type = "t2.micro"
    vpc_security_group_ids = [aws_security_group.test_web_server_sg.id]
    tags = {
        Name = "PROD Web Server"
        Owner = "Petya Pipkin"
    }  
    depends_on = [
      aws_instance.db_server
    ]
}

resource "aws_instance" "db_server" {
    ami = "ami-06616b7884ac98cdd"
    instance_type = "t2.micro"
    vpc_security_group_ids = [aws_security_group.test_web_server_sg.id]
    tags = {
        Name = "DB Server"
        Owner = "Vasya Pupkin"
    }  
}

resource "aws_security_group" "test_web_server_sg" {
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

    tags = {
        Name = "Servers Security Group"
    }
}


