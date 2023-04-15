terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
  required_version = ">= 1.4.0"
}

resource "aws_security_group" "mtc_sg" {
  name        = "dev-sg"
  description = "dev_security_group"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["197.237.29.246/32", "212.22.165.237/32"] # always hard code known source IPs here for SSH | remove 2nd IP
    # cidr_blocks = ["212.22.165.237/32"] # always hard code known source IPs here for SSH | remove 2nd IP
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}
