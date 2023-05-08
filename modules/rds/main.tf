terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
  required_version = ">= 1.4.0"
}

resource "aws_db_instance" "example" {
  identifier              = "example-rds"
  engine                  = "mysql"
  engine_version          = "5.7"
  instance_class          = "db.t2.micro"
  name                    = "chama-dev-db"
  username                = "chama-dev-db-user"
  password                = "lE+j$fC,>IuVhv7"
  allocated_storage       = 20
  backup_retention_period = 7
  maintenance_window      = "Mon:00:00-Mon:03:00"
  vpc_security_group_ids  = [aws_security_group.example.id]

  db_subnet_group_name = aws_db_subnet_group.example.name

  tags = {
    Name = "example-rds"
  }
}

resource "aws_security_group" "example" {
  name_prefix = "example-rds-sg-"
}

resource "aws_db_subnet_group" "example" {
  name       = "example-rds-subnet-group"
  subnet_ids = aws_subnet.example.*.id
}
