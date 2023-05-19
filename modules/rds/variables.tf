variable "identifier" {
  type = string
}

variable "engine" {
  type = string
}

variable "engine_version" {
  type = string
}

variable "instance_class" {
  type = string
}

variable "name" {
  type = string
}

variable "username" {
  type = string
}

variable "password" {
  type = string
}

variable "allocated_storage" {
  type = number
}

variable "backup_retention_period" {
  type = number
}

variable "maintenance_window" {
  type = string
}

variable "vpc_security_group_ids" {
  type = list(number)
}

variable "subnet_group_name" {
  type = string
}

variable "tag_name" {
  type = string
}
