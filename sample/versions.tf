terraform {
  required_providers {

    azurerm = {
        source  = "hashicorp/azurerm"
    }

    random = {
        source = "hashicorp/random"
        version = "3.1.0"
    }

  }

  # backend "azurerm" {
  #   resource_group_name  = "iac-poc-terraform"
  #   storage_account_name = "iacpocterraform"
  #   container_name       = "terraform"
  #   key                  = "iac-poc/terraform/terraform.tfstate"
  # }

  required_version = ">= 0.14.9"
}
