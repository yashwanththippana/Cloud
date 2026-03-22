variable "name" {
  description = "SNS topic name"
  type        = string
}

variable "fifo_topic" {
  description = "Enable FIFO SNS topic"
  type        = bool
  default     = false
}

variable "content_based_deduplication" {
  description = "Enable content-based deduplication for FIFO topics"
  type        = bool
  default     = false
}

variable "email_subscription" {
  description = "Email address for SNS subscription"
  type        = string
  default     = ""
}

variable "sqs_subscription_arn" {
  description = "SQS queue ARN to subscribe"
  type        = string
  default     = ""
}
