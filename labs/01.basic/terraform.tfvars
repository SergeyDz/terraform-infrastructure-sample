variable "instance_type" {
    type = string 
    Description = "AWS EC2 size"
    Default = "t3.micro"
}

variable "subnet_id" {
    type = string 
    Description = "AWS Public Suntet ID"
    Default = "subnet-0fc1e66a47f16eed3"
}