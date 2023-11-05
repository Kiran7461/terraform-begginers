terraform {
  backend "s3" {
    bucket         = "s3-backend-cloud-classes"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "my-table"
  }
}



provider "aws" {
  region     = "us-east-1"
  access_key = ""
  secret_key = ""
}


resource "aws_key_pair" "key-tf" {
  key_name   = "first-key"
  public_key = ""
}


resource "aws_instance" "first-instance" {
  ami             = "ami-04b107e90218672e5"
  instance_type   = "t2.micro"
  key_name        = "first-key"
  security_groups = ["first-sg-tf"]
  tags = {
    Name = "first_ec2_tf"
  }
}

resource "aws_security_group" "sg-tf" {
  name        = "first-sg-tf"
  description = "Allow TLS inbound traffic"

  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "TLS from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "TF-sg"
  }
}
