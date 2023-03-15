provider "aws" {}

resource "aws_instance" "aws_linux_test_01" {
    ami = "ami-06616b7884ac98cdd"
    instance_type = "t2.micro"
  
}

resource "aws_instance" "ubuntu_test_01" {
    ami = "ami-0d1ddd83282187d18"
    instance_type = "t2.micro"
  
}

