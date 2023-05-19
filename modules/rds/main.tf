terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
  required_version = ">= 1.4.0"
}

resource "aws_db_instance" "db_test" {
  identifier              = var.identifier
  engine                  = var.engine
  engine_version          = var.engine_version
  instance_class          = var.instance_class
  db_name                 = var.name
  username                = var.username
  password                = var.password
  allocated_storage       = var.allocated_storage
  backup_retention_period = var.backup_retention_period
  maintenance_window      = var.maintenance_window
  vpc_security_group_ids  = var.vpc_security_group_ids

  db_subnet_group_name = var.subnet_group_name
  tags = {
    Name = var.tag_name
  }
}

# resource "aws_security_group" "example" {
#   name_prefix = "example-rds-sg-"
# }

# resource "aws_db_subnet_group" "example" {
#   name       = "example-rds-subnet-group"
#   subnet_ids = aws_subnet.example.*.id
# }
