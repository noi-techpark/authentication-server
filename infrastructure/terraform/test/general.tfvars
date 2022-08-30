terraform {
  backend "s3" {
    bucket = "it.bz.opendatahub.auth-terraform"
    key    = "test"
    region = "eu-west-1"
  }
}

target_group_arn = "arn:aws:elasticloadbalancing:eu-west-1:755952719952:targetgroup/test-keycloak-servers/82a7a27a96ebb066"
