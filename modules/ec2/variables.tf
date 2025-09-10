variable "ami" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "tag_role" {
  type = string
}

variable "tag_name" {
  type = string
}

variable "eip_name" {
  type = string
}

variable "eip_domain" {
  type = string
}

variable "ec2_user_data" {
  type = string
}

variable "ec2_subnet_id" {
  type = string
}

variable "security_group_id" {
  type = string
}

variable "ec2_iam_instance_profile" {
  type    = string
  default = null
}
