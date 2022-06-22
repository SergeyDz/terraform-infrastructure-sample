variable "instance_type" {
    type = string 
    description = "AWS EC2 size"
}

variable "subnet_id" {
    type = string 
    description = "AWS Public Suntet ID"
}

variable "ami" {
    type = string
    description = "AMI with Amazon Linux"
    default = "ami-0cff7528ff583bf9a"
}