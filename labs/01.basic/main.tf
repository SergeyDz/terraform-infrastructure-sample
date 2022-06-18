provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "vm" {
  ami           = "ami-0cff7528ff583bf9a"
  subnet_id     = "subnet-014a79b070ccb260d"
  instance_type = "t3.micro"
  tags = {
    Name = "my-first-tf-node"
  }
}
