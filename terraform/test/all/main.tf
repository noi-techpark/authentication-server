provider "aws" {
  version = "~> 2.0"
  region = "eu-west-1"
  profile = "noi"
}

resource "aws_lb_target_group_attachment" "target-i-0f67ed9de340c8394" {
  target_group_arn = "arn:aws:elasticloadbalancing:eu-west-1:755952719952:targetgroup/test-keycloak-servers/82a7a27a96ebb066"
  target_id  =   "i-0f67ed9de340c8394"
  port = 8080
}

resource "aws_lb_target_group_attachment" "target-i-0c3a9911bc818a769" {
  target_group_arn = "arn:aws:elasticloadbalancing:eu-west-1:755952719952:targetgroup/test-keycloak-servers/82a7a27a96ebb066"
  target_id  = "i-0c3a9911bc818a769"
  port = 8080
}
