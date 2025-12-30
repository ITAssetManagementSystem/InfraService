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
  subscription_id = "a46e2f32-e4a1-44bf-946c-f3fa4a273aa1"
  # Configuration options
}