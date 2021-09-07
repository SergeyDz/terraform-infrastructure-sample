variable "instance_type" {
  description = "Azure instance type"
  default = "Standard_D4s_v3"
}

variable "location" {
  description = "Azure region"
  default = "West Europe"
}

variable "cloudinit_file" {
    description = "Ps file for cloud init"
    default = "init.ps1"
}