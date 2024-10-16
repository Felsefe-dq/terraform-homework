provider aws {
    region = "us-east-1"
}

resource "aws_key_pair" "deployer" {
  key_name   = "Bastion-key"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_s3_bucket" "example" {
   bucket = "kaizen-datkaiym4509"
}


resource "aws_s3_bucket" "example2" {
   bucket_prefix = "kaizen-"
   
}

resource "aws_s3_bucket" "mn" {
   bucket = "manual34"
}

resource "aws_s3_bucket" "mn2" {
   bucket = "manual98"
}
