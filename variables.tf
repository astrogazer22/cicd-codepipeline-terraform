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

variable "repo_owner" {
  type    = string
  default = "astrogazer22"
}

variable "availability_zone" {
  type    = string
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

variable "log_retention_period" {
  type    = number
  default = 7
}

variable "cloudwatch_log_path" {
  type    = string
  default = "/ec2/app/logs"
}

variable "tag_role" {
  type    = string
  default = "nodejs-deploy"
}

variable "tag_name" {
  type    = string
  default = "nodejs-server-1"
}

variable "tag_s3_name" {
  type    = string
  default = "My bucket"
}

variable "tag_s3_environment" {
  type    = string
  default = "Dev"
}

variable "tag_subnet" {
  type    = string
  default = "public subnet"
}

variable "codebuild_timeout" {
  type    = number
  default = 5
}

variable "codebuild_compute_type" {
  type    = string
  default = "BUILD_GENERAL1_SMALL"
}

variable "codebuild_image" {
  type    = string
  default = "aws/codebuild/standard:6.0"
}

variable "codebuild_container_type" {
  type    = string
  default = "LINUX_CONTAINER"
}

variable "codebuild_credential_type" {
  type    = string
  default = "CODEBUILD"
}

variable "codebuild_artifact" {
  type    = string
  default = "CODEPIPELINE"
}

variable "codebuild_source_type" {
  type    = string
  default = "CODEPIPELINE"
}

variable "codebuild_source_buildspec" {
  type    = string
  default = "buildspec.yml"
}

variable "codebuild_environment_tag" {
  type    = string
  default = "production"
}

variable "codebuild_project_tag" {
  type    = string
  default = "ci-cd-demo"
}

variable "aws_region" {
  type = string
  default = "ap-southeast-1"
}
