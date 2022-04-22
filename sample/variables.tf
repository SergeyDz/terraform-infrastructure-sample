variable "instance_type" {
  description = "Azure instance type"
  default = "Standard_B2s"
}

variable "location" {
  description = "Azure region"
  default = "East US"
}

variable "cloudinit_file" {
  description = "Cloud init file"
  default = "init.ps1"
}

variable "resourcegroup" {
  description = "Azure Resource Group"
  default = "1-173b9f42-playground-sandbox"
}

variable "subscriptionid" {
  description = "Azure Subscribtion Id"
  default = "4cedc5dd-e3ad-468d-bf66-32e31bdb9148"
}

# variable "subscription_id" {
#     description = "subscription_id"
#     default = "1"
# }

# variable "client_id" {
#     description = "client_id"
#     default = "2"
# }

# variable "client_secret" {
#     description = "client_secret"
#     default = "3"
# }

# variable "tenant_id" {
#     description = "tenant_id"
#     default = "4"
# }
