resource "random_string" "virtual_network_id" {
  keepers = {
    platform_instance_name = var.platform_instance_name
    name                   = var.name
    location               = var.location
  }

  length      = 3
  min_numeric = 1
  special     = false
  upper       = false
}

locals {
  virtual_network_name = "${var.platform_instance_name}-${var.name}-${random_string.virtual_network_id.result}"
}

resource "azurerm_resource_group" "default" {
  name     = local.virtual_network_name
  location = var.location
}

resource "azurerm_virtual_network" "default" {
  name                = local.virtual_network_name
  address_space       = var.cidr
  location            = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name
}
