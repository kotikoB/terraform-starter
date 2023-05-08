variable "identifier" {
  type = string
}

variable "engine" {
  type = string
}

variable "engine" {
  type = string
}

variable "db_user" {
  type = string
}

variable "db_name" {
  type = string
}

variable "db_password" {
  type = string
}

variable "db_maintenance_window" {
  type = string
}

variable "db_subnet_group_name" {
  type = string
}

variable "vpc_security_group_ids" {
  type = list(number)
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
