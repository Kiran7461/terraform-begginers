resource "aws_key_pair" "key-tf" {
  key_name   = "first-key"
  public_key = ""
}



resource "aws_instance" "first-instance" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name = "first-key"
  security_groups = ["first-sg-tf"]
  tags = {
    Name = "first_ec2_tf"
  }
}

resource "aws_security_group" "sg-tf" {
  name        = "first-sg-tf"
  description = "Allow TLS inbound traffic"

  ingress {
    description      = "TLS from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "TCP"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "TLS from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "TCP"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "TF-sg"
  }
}
