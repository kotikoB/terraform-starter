terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
  required_version = ">= 1.4.0"
}

resource "aws_key_pair" "mtc_auth" {
  key_name   = "mtckey"
  public_key = file("~/.ssh/mtckey.pub")
}

resource "aws_instance" "ec2_web_server_dev_node" {
  instance_type          = "t3.micro" # t3.micro also works in free tier
  ami                    = var.ec2_ami
  key_name               = aws_key_pair.mtc_auth.key_name #aws_key_pair.mtc_auth.id
  vpc_security_group_ids = var.security_group_ids
  subnet_id              = var.subnet_id
  user_data              = file("./modules/ec2/userdata.tpl")

  root_block_device {
    volume_size = 10
  }

  # Provisioners are a last resort. NEVER EVER user them.
  # Provisioners have no roll backs incase of failuers, the enite script must be rerun
  # Use ansible instaead
  provisioner "local-exec" {
    command = templatefile("./modules/ec2/${var.host_os}-ssh-config.tpl", {
      hostname     = self.public_ip,
      user         = "ubuntu",
      identityfile = "~/.ssh/mtckey"
    })
    interpreter = var.host_os == "windows" ? ["powershell", "-Command"] : ["bash", "-c"]
  }

  tags = {
    Name = var.tag_name
  }
}

