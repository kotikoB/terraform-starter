terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
  required_version = ">= 1.4.0"
}

# Create a database server
resource "aws_db_instance" "test_db" {
  identifier              = var.identifier
  engine                  = var.engine
  engine_version          = var.engine_version
  instance_class          = var.instance_class
  db_name                 = var.db_name
  username                = var.username
  password                = var.password
  allocated_storage       = var.allocated_storage
  backup_retention_period = var.backup_retention_period
  maintenance_window      = var.maintenance_window

  # Add your existing security group IDs here
  vpc_security_group_ids = var.vpc_security_group_ids
  db_subnet_group_name   = aws_db_subnet_group.test_db_subnet_group.name

  tags = {
    Name = var.tag_name
  }
}

resource "aws_security_group" "rds_test_sg" {
  name_prefix = "rds-test_db-sg-"
}

resource "aws_db_subnet_group" "test_db_subnet_group" {
  name       = "rds-test_db-subnet-group"
  subnet_ids = var.subnet_ids
}
