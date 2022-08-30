terraform {
  backend "s3" {
    bucket = "it.bz.opendatahub.auth-terraform"
    key    = "prod"
    region = "eu-west-1"
  }
}

target_group_arn = "arn:aws:elasticloadbalancing:eu-west-1:755952719952:targetgroup/prod-keycloak-servers/608f83d5b592f368"
