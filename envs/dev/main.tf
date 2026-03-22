terraform {
  required_version = ">= 1.0.0"
}

provider "aws" {
  region = var.region
}

# SNS Module (only runs when service = sns)
module "sns" {
  count  = var.service == "sns" ? 1 : 0
  source = "../../modules/sns"

  name                        = var.sns_topic_name
  email_subscription          = var.sns_email_subscription
  fifo_topic                  = var.sns_fifo
  content_based_deduplication = var.sns_dedup
}
