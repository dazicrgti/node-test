resource "azurerm_mssql_server" "mssqlserver" {
name = var.mssql_server_name_prefix
resource_group_name = azurerm_resource_group.rg.name
location = azurerm_resource_group.rg.location
version = "12.0"
administrator_login = "gtiadmin"
administrator_login_password = random_password.password.result
minimum_tls_version = "1.2"
}