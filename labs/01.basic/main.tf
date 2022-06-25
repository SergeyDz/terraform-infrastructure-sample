provider "aws" {
  region = "us-east-1"
}
resource "aws_instance" "vm" {
  ami           = var.ami
  subnet_id     = var.subnet_id
  instance_type = var.instance_type
  tags          = var.tags

  provisioner "local-exec" {
    command = "sudo apt-get update -y && sudo apt-get install -y mc nano htop python3-pip"
  }

  provisioner "local-exec" {
    command = "sudo apt-get install -y apache2"
  }

}
