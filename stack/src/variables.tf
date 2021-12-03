variable "name" {
  type        = string
  description = "Azure Virtual Network (vnet) Name"
}

variable "resource_group_name" {
  type        = string
  description = "Azure Virtual Network (vnet) Resource Group Name"
}

variable "location" {
  type        = string
  description = "Azure Region"
  default     = "eastus2"
}
