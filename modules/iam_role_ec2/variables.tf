variable "ec2_role_policy_arn" {
  type    = string
  default = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforAWSCodeDeploy"
}


variable "role_name" {
  type = string
}

variable "managed_policy_arns" {
  type = list(string)
}
