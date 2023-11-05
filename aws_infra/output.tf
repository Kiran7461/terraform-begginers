output "publicIP" {
  value = module.ec2.publicIP
}

output "vpc" {
  value = module.vpc.vpc_id
}
