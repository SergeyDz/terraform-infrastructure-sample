provider "aws" {
  region = "us-east-1"
}
resource "aws_instance" "vm" {
  ami           = var.ami
  subnet_id     = var.subnet_id
  instance_type = var.instance_type
  tags = var.tags
}
