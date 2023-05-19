variable "host_os" {
  type    = string
  default = "windows" # This will be overwritten by calue in .tfvars file
}

variable "instance_type" {
  type    = string
  default = "t3.micro" # t3.micro works in free tier
}

variable "ec2_ami" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "security_group_ids" {
  type = list(string)
}

variable "tag_name" {
  type = string
}
