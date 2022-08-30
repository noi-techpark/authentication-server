variable "aws_region" {
  type = string
}

variable "target_group_arn" {
  type = string
}

variable "target_group_port" {
  type = number
}

variable "target_group_one_ids" {
  type = map(string)
}

variable "target_group_two_ids" {
  type = map(string)
}
