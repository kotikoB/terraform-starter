resource "aws_vpc" "chama_dev_vpc" {
  cidr_block           = "10.123.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "dev"
  }
}
module "public_subnet" {
  source = "./modules/subnet"
  vpc_id = aws_vpc.chama_dev_vpc.id
}

resource "aws_internet_gateway" "mtc_internet_gateway" {
  vpc_id = aws_vpc.chama_dev_vpc.id
  tags = {
    Name = "dev_internet_gateway"
  }
}

resource "aws_route_table" "mtc_public_rt" {
  vpc_id = aws_vpc.chama_dev_vpc.id
  tags = {
    Name = "dev_public_rt"
  }
}

resource "aws_route" "default_route" {
  route_table_id         = aws_route_table.mtc_public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.mtc_internet_gateway.id
}

resource "aws_route_table_association" "mtc_public_assoc_a" {
  subnet_id      = module.public_subnet.instance.id
  route_table_id = aws_route_table.mtc_public_rt.id
}

module "public_security_group_1" {
  source = "./modules/security_group"
  vpc_id = aws_vpc.chama_dev_vpc.id
}

module "chama_api_server_dev" {
  source             = "./modules/ec2"
  ec2_ami            = data.aws_ami.chama_ami.id
  security_group_ids = [module.public_security_group_1.instance.id]
  subnet_id          = module.public_subnet.instance.id
  host_os            = "unix"
  tag_name           = "chama_api_server_dev"
}

module "stop_ec2_instances" {
  source              = "github.com/julb/terraform-aws-lambda-auto-start-stop-ec2-instances"
  name                = "StopEc2Instances"
  schedule_expression = "cron(0 20 * * ? *)" #Stop server at 7pm
  action              = "stop"
  tags                = { "Name" : "stopEc2Instance" }
  lookup_resource_tag = {
    key   = "Name"
    value = "chama_api_server_dev"
  }
}

module "start_ec2_instances" {
  source              = "github.com/julb/terraform-aws-lambda-auto-start-stop-ec2-instances"
  name                = "StartEc2Instances"
  schedule_expression = "cron(0 10 * * ? *)" #Start server at 10am
  action              = "start"
  tags                = { "Name" : "startEc2Instance" }
  lookup_resource_tag = {
    key   = "Name"
    value = "chama_api_server_dev"
  }
}

# Create ansible inventory file from created instances
resource "local_file" "ansible_inventory" {
  content  = module.chama_api_server_dev.instance.public_ip
  filename = "_ansible/ansible_inventory.txt"
}

#TODO: Checkout infracost.io
