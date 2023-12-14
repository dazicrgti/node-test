output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "azurerm_mssql_server" {
  value = azurerm_mssql_server.mssqlserver.name
}

output "azurerm_mssql_database_name" {
  value = azurerm_mssql_database.mssqldb.name
}

output "azurerm_mssql_database_collation" {
  value = azurerm_mssql_database.mssqldb.collation
}
output "admin_login" {
  value = azurerm_mssql_server.mssqlserver.administrator_login
}

output "admin_password" {
  sensitive = true
  value     = azurerm_mssql_server.mssqlserver.administrator_login_password
}

