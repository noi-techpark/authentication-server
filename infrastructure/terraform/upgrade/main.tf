terraform {
  backend "s3" {
    bucket = "it.bz.opendatahub.auth-terraform"
    key    = "upgrade"
    region = "eu-west-1"
  }
}

variable "target_group_one_ids" {
  type = map(string)
}

variable "target_group_two_ids" {
  type = map(string)
}

module "aws_load_balancer_target_group" {
  source = "../aws-load-balancer-target-group"
  aws_region = "eu-west-1"
  target_group_arn = "arn:aws:elasticloadbalancing:eu-west-1:755952719952:targetgroup/upgrade-keycloak-servers/cb36a22b155ba880"
  target_group_one_ids = var.target_group_one_ids
  target_group_two_ids = var.target_group_two_ids
  target_group_port = 8080
}
