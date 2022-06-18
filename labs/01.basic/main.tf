provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "vm" {
  ami           = "ami-0cff7528ff583bf9a"
  subnet_id     = "subnet-04206cc6315f87c35"
  instance_type = "t3.micro"
  tags = {
    Name = "my-first-tf-node"
  }
}
