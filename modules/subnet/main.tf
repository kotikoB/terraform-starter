terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
  required_version = ">= 1.4.0"
}

resource "aws_subnet" "mtc_public_subnet" {
  vpc_id                  = var.vpc_id
  cidr_block              = "10.123.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "eu-west-1c"

  tags = {
    Name = "dev_public_subnet"
  }
}
