provider "aws" {
  region     = "us-east-1"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners = ["099720109477"]
  tags = {
    Name   = "demo-ami"
    Tested = "true"
  }

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_key_pair" "key-tf" {
  key_name   = "first-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCe1bZjoeMtCPFlhtf7aKT2hLtu18h1XZoIw7Zb2vSFcR37YDwwFl90lGP68LZT8HycQY5x5VlnVFra5JhXN7NgCgKGUt+gYikBOB3ykTJrP0/o1g+TCjc9q5FkdPQtdEF9TV20Zq0CFXkrzZQdu+NHUEbt9rOdJP7ekENAiK4+0N2FvVWibgJfoMxeHXzsDjmboWhzvE0zIBccrrDB6yoFgWeXnynan0f4MkTp9i2o+9ty70YLNDHPXqMy7KukgHQ61d5jIxwTwwwVNLnHn+2hFnXAexQKJ7FfQ9QN3wBEacpmY/VNVtr32uBKDpXELdU9wmtdTdgwE2q0Cr3DSMym2HCYJu7fNHWPIGAm8/NDQUL/mPfhWHvYyQMOxnWmg1hWxJIKOWL8Ab7cGbjt17IbabxjVINvaIOB4baufk/37C0X+gVityU18y0KaRfy1D+QzjFa8TuJLxDo3mJaIcrTVmXG/56ZK5xVWva2hcoO2673eIJxpqPlrXt8O6H2bKE= ubuntu@ip-172-31-33-249"
}


resource "aws_instance" "first-instance" {
  ami             = data.aws_ami.ubuntu.id
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
