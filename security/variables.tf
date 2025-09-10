variable "codedeploy_role_policy_arn" {
  type    = string
  default = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforAWSCodeDeploy"
}

variable "ec2_profile_head" {
  type    = string
  default = "value"
}

variable "port_22" {
  type    = number
  default = 22
}

variable "port_80" {
  type    = number
  default = 80
}

variable "port_443" {
  type    = number
  default = 443
}

variable "port_3306" {
  type    = number
  default = 3306
}

variable "null" {
  type    = number
  default = 0
}

variable "protocol_tcp" {
  type    = string
  default = "tcp"
}

variable "protocol_all" {
  type    = number
  default = -1
}

variable "cidr_block_all" {
  type    = string
  default = "0.0.0.0/0"
}

variable "cidr_ipv6" {
  type    = string
  default = "::/0"
}

variable "tag_subnet" {
  type    = string
  default = "public subnet"
}

variable "cidr_block_vpc" {
  type    = string
  default = "10.0.1.0/24"
}

variable "availability_zone" {
  type    = string
  default = "ap-southeast-1a"
}

variable "vpc_id" {
  type = string
  
}
