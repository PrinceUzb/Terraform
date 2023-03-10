provider "aws" {
  region = "us-west-2"
}

resource "aws_instance" "my_ubuntu" {
  ami                    = "ami-0735c191cf914754d"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.my_webserver.id]
  tags                   = {
    Name    = "Ubuntu server"
    Owner   = "Prince"
    Project = "Terraform lessons"
  }
  user_data = file("user-data.sh")
}

# Default VPC
resource "aws_default_vpc" "default" {}

resource "aws_security_group" "my_webserver" {
  name        = "Webserver SG"
  vpc_id      = aws_default_vpc.default.id
  description = "TEST"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
output "aws_instance_public_dns" {
  value = aws_instance.my_ubuntu.public_dns
}