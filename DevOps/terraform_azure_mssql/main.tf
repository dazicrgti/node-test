resource "azurerm_resource_group" "rg" {
name = var.resource_group_name_prefix
location = var.resource_group_location
}

resource "azurerm_storage_account" "sa" {
name = var.storage_account_name_prefix
resource_group_name = azurerm_resource_group.rg.name
location = azurerm_resource_group.rg.location
account_tier = "Standard"
account_replication_type = "LRS"
}

# Generate random value for the login password
resource "random_password" "password" {
  length           = 8
  lower            = true
  min_lower        = 1
  min_numeric      = 1
  min_special      = 1
  min_upper        = 1
  numeric          = true
  override_special = "_"
  special          = true
  upper            = true
}

