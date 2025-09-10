variable "codedeploy_trigger_target_arn" {
  type = string
  default = null
}

variable "codedeploy_compute_platform" {
  type    = string
}

variable "codedeploy_deployment_group_name" {
  type    = string
}

variable "codedeploy_deployment_config_name" {
  type    = string
}

variable "codedeploy_ec2_tag_key" {
  type    = string
}

variable "codedeploy_ec2_tag_type" {
  type    = string
}

variable "codedeploy_ec2_tag_value" {
  type    = string
}

variable "codedeploy_start_event" {
  type    = string

}

variable "codedeploy_success_event" {
  type    = string
}

variable "codedeploy_failure_event" {
  type    = string
}

variable "codedeploy_auto_rollback_failure" {
  type = string
}

variable "codedeploy_trigger_name" {
  type    = string
}

variable "codedeploy_role_name" {
  type    = string
}

variable "codedeploy_service_role_name" {
  type    = string
}

variable "codedeploy_policy_name" {
  type    = string
}
