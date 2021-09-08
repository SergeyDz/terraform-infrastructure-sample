terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.66.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "learning"
    storage_account_name = "sergeydzyuban"
    container_name       = "terraform"
    key                  = "aks/terraform.tfstate"
  }

  required_version = ">= 0.14"
}