variable "resource_group_location" {
  type        = string
  default     = "eastasia"
  description = "Location of the resource group."
}

variable "resource_group_name_prefix" {
  type        = string
  default     = "rg-brian-mysql-fs-db"
  description = "Set Resource Group Name for mysql db flexible serer."
}

variable "vnet_name_prefix" {
  type        = string
  default     = "vnet-brian-mysql-fs-db"
  description = "Set Vitrual Network name for mysql db."
}

variable "subnet_name_prefix" {
  type        = string
  default     = "subnet-brian-mysql-fs-db"
  description = "Set subnet name for mysql db."
}