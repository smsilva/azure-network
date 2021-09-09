locals {
  address_prefixes = var.cidrs
}

resource "azurerm_subnet" "default" {
  name                 = var.name
  address_prefixes     = local.address_prefixes
  virtual_network_name = var.vnet.name
  resource_group_name  = var.resource_group.name
}
