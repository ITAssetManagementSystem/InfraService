terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.57.0"
    }
    #   time = {
    #   source = "hashicorp/time"
    # }
  }
}

provider "azurerm" {
  features {

  }
  subscription_id = "6b085240-a951-404c-8e9c-110ec63f18de"
  # Configuration options
}
