provider "aws" {
  region     = "us-east-1"
  access_key = var.access_key
  secret_key = var.secret_key
}

module "ec2" {
  source        = "./modules/ec2"
  image_id      = var.image_id
  instance_type = var.instance_type
  
}

module "vpc" {
  source = "./modules/vpc"
  public_subnet_cidrs = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
}
