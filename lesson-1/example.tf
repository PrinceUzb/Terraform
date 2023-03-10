provider "aws" {
  region = "us-west-2"
}

resource "aws_instance" "my_ubuntu" {
  ami           = "ami-0735c191cf914754d"
  instance_type = "t2.micro"
  tags          = {
    Name    = "Ubuntu server"
    Owner   = "Prince"
    Project = "Terraform lessons"
  }
}