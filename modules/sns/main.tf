resource "aws_kms_key" "sns_kms" {
  description = "KMS key for SNS topic encryption"
  enable_key_rotation = true
}

resource "aws_sns_topic" "this" {
  name                        = var.name
  fifo_topic                  = var.fifo_topic
  content_based_deduplication = var.content_based_deduplication
  kms_master_key_id           = aws_kms_key.sns_kms.arn
}

resource "aws_sns_topic_subscription" "email" {
  count = var.email_subscription == "" ? 0 : 1

  topic_arn = aws_sns_topic.this.arn
  protocol  = "email"
  endpoint  = var.email_subscription
}

resource "aws_sns_topic_subscription" "sqs" {
  count = var.sqs_subscription_arn == "" ? 0 : 1

  topic_arn = aws_sns_topic.this.arn
  protocol  = "sqs"
  endpoint  = var.sqs_subscription_arn
}
