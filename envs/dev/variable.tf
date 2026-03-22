variable "service" {
  description = "The AWS service to deploy (sns, ecs, alb, cloudmap, secretsmanager, ecr, autoscaling, cloudwatch, inspector)"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

# SNS-specific variables
variable "sns_topic_name" {
  description = "SNS topic name"
  type        = string
  default     = "dev-topic"
}

variable "sns_email_subscription" {
  description = "Email address for SNS subscription"
  type        = string
  default     = ""
}

variable "sns_fifo" {
  description = "Enable FIFO SNS topic"
  type        = bool
  default     = false
}

variable "sns_dedup" {
  description = "Enable content-based deduplication for FIFO SNS topics"
  type        = bool
  default     = false
}
