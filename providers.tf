terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

# TODO: User aws credentials file instead
provider "aws" {
  access_key = "AKIAT34OCEUISZ6DZLC3"
  secret_key = "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"
  region     = "eu-west-1"
}
