provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "vm" {
  ami           = "ami-0cff7528ff583bf9a"
  subnet_id     = var.subnet_id
  instance_type = var.instance_type
  tags = {
    Name = "my-first-tf-node"
  }
}
