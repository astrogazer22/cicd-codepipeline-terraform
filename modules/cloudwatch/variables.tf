variable "alarm_name" {
  type = string
}

variable "comparison_operator" {
  type = string
}

variable "metric_name" {
  type = string
}

variable "cloudwatch_evaluation_period" {
  type = number
}

variable "namespace" {
  type = string
}

variable "metric_period" {
  type = number
}

variable "metric_statistic" {
  type = string
}

variable "metric_threshold" {
  type = number
}

variable "log_retention_period" {
  type = number
}

variable "cloudwatch_log_path" {
  type = string
}

variable "cloudwatch_instance_id" {}

variable "cloudwatch_alarm_actions" {}
