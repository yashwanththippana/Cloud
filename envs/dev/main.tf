variable "service" {
  type = string
}

module "sns" {
  source = "../../modules/sns"
  name   = "my-sns-topic"
  count  = var.service == "sns" ? 1 : 0
}

