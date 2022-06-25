provider "aws" {
  region = "us-east-1"
}

resource "tls_private_key" "vm" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = var.key_name
  public_key = tls_private_key.vm.public_key_openssh
  provisioner "local-exec" { 
    command = "echo '${tls_private_key.vm.private_key_pem}' > ./${var.key_name}.temporary.pem"
  }
}
resource "aws_instance" "vm" {
  ami           = var.ami
  subnet_id     = var.subnet_id
  instance_type = var.instance_type
  key_name      = aws_key_pair.generated_key.key_name
  tags          = var.tags

  provisioner "local-exec" {
    command = "sudo apt-get update -y && sudo apt-get install -y mc nano htop python3-pip"
  }

  provisioner "local-exec" {
    command = "sudo apt-get install -y apache2"
  }

}
