variable "instance_type" {
    type = string 
    description = "AWS EC2 size"
    default = "t3.micro"
}

variable "subnet_id" {
    type = string 
    description = "AWS Public Suntet ID"
    default = "subnet-0fc1e66a47f16eed3"
}