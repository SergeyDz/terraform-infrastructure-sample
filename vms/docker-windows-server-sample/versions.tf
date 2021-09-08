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

  required_version = ">= 0.14.9"
}