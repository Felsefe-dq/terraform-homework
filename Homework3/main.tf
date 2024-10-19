provider "aws" {
  region = "us-west-2"
}

resource "aws_key_pair" "deployer" {
  key_name   = "Bastion-key"
  public_key = file("~/.ssh/id_rsa.pub")
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

data "aws_vpc" "default" {
  default = true
}


resource "aws_instance" "web" {
  count                  = 3
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = "t2.micro"
  key_name               = "Bastion-key" 
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  #   security_groups   = [aws_security_group.allow_tls.id]
  availability_zone = element(["us-west-2a", "us-west-2b", "us-west-2c"], count.index)
  user_data         = file("apache.sh")


  tags = {
    Name = "web-${count.index + 1}"
  }
}
