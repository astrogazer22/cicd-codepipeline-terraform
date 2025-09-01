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

variable "ami" {
  type    = string
  default = "ami-0d8ec96c89ad62005"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "github_token" {
  type    = string
  default = ""
}

variable "repo_owner" {
  type    = string
  default = "astrogazer22"
}

variable "cidr_block_vpc" {
  type    = string
  default = "10.0.1.0/24"
}

variable "availability_zone" {
  type = string
  default = "ap-southeast-1a"
}

variable "alarm_name" {
  type    = string
  default = "HighCPUUtilization"
}

variable "comparison_operator" {
  type    = string
  default = "GreaterThanThreshold"
}

variable "metric_name" {
  type    = string
  default = "CPUUtilization"
}

variable "cloudwatch_evaluation_period" {
  type    = number
  default = 2
}

variable "namespace" {
  type    = string
  default = "AWS/EC2"
}

variable "metric_period" {
  type    = number
  default = 120
}

variable "metric_statistic" {
  type    = string
  default = "Average"
}

variable "metric_threshold" {
  type    = number
  default = 70
}
