variable "host_os" {
  type    = string
  default = "windows" # This will be overwritten by calue in .tfvars file
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
