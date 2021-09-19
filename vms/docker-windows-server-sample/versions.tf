terraform {
  required_providers {

    azurerm = {
        source  = "hashicorp/azurerm"
        version = "~> 2.75.0"
    }

    random = {
        source = "hashicorp/random"
        version = "3.1.0"
    }

  }

  backend "azurerm" {
    resource_group_name  = "learning"
    storage_account_name = "sergeydzyuban"
    container_name       = "terraform"
    key                  = "vm/terraform.tfstate"
  }

  required_version = ">= 0.14.9"
}
