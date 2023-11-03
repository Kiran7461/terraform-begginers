
provider "aws" {
  region     = "us-east-1"
  access_key = " "
  secret_key = " "
}

#variables

variable "ami" {
  default = "ami-04b107e90218672e5"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "ports" {
  default = [22, 80, 443, 8080]
}

#resource 

resource "aws_key_pair" "key-tf" {
  key_name   = "third-key"
  public_key = file("${path.module}/aws.pub")
}


resource "aws_instance" "third-instance-tf" {
  ami             = var.ami
  instance_type   = var.instance_type
  key_name        = "third-key"
  security_groups = ["first-sg_3"]
  tags = {
    Name = "third_ec2_tf"
  }


  connection {
        type        = "ssh"
        user        = "ubuntu"
        private_key = file("${path.module}/aws")
        host        = self.public_ip
  }
  provisioner "file" {
    source      = "/home/ubuntu/git/terraform-begginers/provisionsers/demo"
    destination = "/home/ubuntu/demo"  
  }

  provisioner "file" {
      source = "/home/ubuntu/git/terraform-begginers/provisionsers/file10"
      destination = "/home/ubuntu/file10"
  }
   
  provisioner "local-exec" {
    command = "echo ${self.public_ip} > /tmp/mypublicip.txt"
  }

  provisioner "remote-exec" {
    inline = [
      "ifconfig > /tmp/ifconfig.output",
      "echo 'cloud_classes'>/tmp/test.txt"
    ]
  }
   provisioner "remote-exec" {
   script = "./script.sh"
 }

}

#security group

resource "aws_security_group" "sg-tf_3" {
  name        = "first-sg_3"
  description = "Allow TLS inbound traffic"

  dynamic "ingress" {
    for_each = var.ports
    iterator = port
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  dynamic "egress" {
    for_each = var.ports
    iterator = port
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  tags = {
    Name = "TF-sg_3"
  }
}
