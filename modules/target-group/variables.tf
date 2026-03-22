variable "name" {}
variable "port" {}
variable "protocol" {}
variable "vpc_id" {}
variable "target_type" { default = "ip" }
variable "health_check_path" { default = "/" }
