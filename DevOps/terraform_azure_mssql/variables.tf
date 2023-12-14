variable "resource_group_location" {
  type        = string
  default     = "eastasia"
  description = "Location of the resource group."
}

variable "resource_group_name_prefix" {
  type        = string
  default     = "rg-dazi-test-mssql"
  description = " resource group name in your Azure subscription."
}

variable "storage_account_name_prefix" {
  type        = string
  default     = "sadazitestmssql"
  description = " storage account name for mssql"
}

variable "mssql_server_name_prefix" {
  type        = string
  default     = "dazi-test-mssql-server"
  description = "MSSQL server name"
}

variable "mssql_db_name_prefix" {
  type        = string
  default     = "dazitestmssqldatabase"
  description = "MSSQL database name"
}

variable "mssqldb_collation" {
  type        = string
#  default     = "Chinese_Taiwan_Stroke_CI_AS"
  default     = "SQL_Latin1_General_CP1_CI_AS"
  description = "MSSQL database collation"
}