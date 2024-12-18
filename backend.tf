/*terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }*/
terraform {
  backend "azurerm" {
    resource_group_name  = "Sowmi_RG"
    storage_account_name = "terraformstate12341712"
    container_name       = "terraformstate"
    key                  = "terraform.tfstate"
  }
}

/*provider "azurerm" {
  features {}
  subscription_id = "******************************"
  tenant_id       = "******************************"
  client_id       = "******************************"
  client_secret   = "******************************"
}*/

# MySQL Server
resource "azurerm_postgresql_server" "postgresqlserver1" {
  name                = "postgresqlserver1678945unique"
  resource_group_name      = "Sowmi_RG"
  location                 = "East US"

  sku_name = "B_Gen5_2"

  storage_mb                   = 5120
  backup_retention_days        = 7
  geo_redundant_backup_enabled = false
  auto_grow_enabled            = true

  administrator_login          = "psqladmin"
  administrator_login_password = "H@Sh1CoR3!"
  version                      = "9.5"
  ssl_enforcement_enabled      = true
}

resource "azurerm_postgresql_database" "postgresqldb" {
  name                = "postgresqldb"
  resource_group_name      = "Sowmi_RG"
  server_name         = azurerm_postgresql_server.postgresqlserver1.name
  charset             = "UTF8"
  collation           = "English_United States.1252"

  # prevent the possibility of accidental data loss
  lifecycle {
    prevent_destroy = true
  }
}