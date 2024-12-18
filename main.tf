terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}
provider "azurerm" {
  features {}
  subscription_id = "******************************"
  tenant_id = "******************************"
  client_id = "******************************"
  client_secret = "******************************"
}

resource "azurerm_storage_account" "storageacc" {
  name                     = "terraformstate12341712"
  resource_group_name      = "Sowmi_RG"
  location                 = "East US"
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = "staging"
  }
}

resource "azurerm_storage_container" "terraformstate" {
  name                  = "terraformstate"
  storage_account_name  = azurerm_storage_account.storageacc.name
  container_access_type = "blob"
}
