variable "access_key" {
  type = string
}

variable "secret_key" {
  type = string
}

variable "image_id" {
  type = string
}
variable "instance_type" {
  type = string
}

variable "public_subnet_cidrs" {
 type        = list(string)
 description = "Public Subnet CIDR values"
 
}

variable "private_subnet_cidrs" {
 type        = list(string)
 description = "Private Subnet CIDR values"
 
}
