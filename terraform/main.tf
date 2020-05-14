provider "aws" {
  version = "~> 2.0"
  region = "eu-west-1"
}

variable "target_group_arn" {
  type = string
}

variable "target_group_one" {
  type = map(string)
}

variable "target_group_two" {
  type = map(string)
}

resource "aws_lb_target_group_attachment" "target-group-one" {
  target_group_arn = var.target_group_arn
  target_id = each.value
  port = 8080

  for_each = var.target_group_one
}

resource "aws_lb_target_group_attachment" "target-group-two" {
  target_group_arn = var.target_group_arn
  target_id = each.value
  port = 8080

  for_each = var.target_group_two
}
