terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

# TODO: User aws credentials file instead
provider "aws" {
  access_key = "XXXX"
  secret_key = "XXXX"
  region     = "eu-west-1"
}
