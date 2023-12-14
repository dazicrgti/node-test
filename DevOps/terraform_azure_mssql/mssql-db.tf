resource "azurerm_mssql_database" "mssqldb" {
  name           = var.mssql_db_name_prefix
  server_id      = azurerm_mssql_server.mssqlserver.id
  collation      = var.mssqldb_collation
#  license_type   = "LicenseIncluded"
#  max_size_gb    = 5
#  read_scale     = true
  sku_name       = "Basic"
#  zone_redundant = true
}