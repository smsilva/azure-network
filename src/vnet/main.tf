resource "azurerm_virtual_network" "default" {
  name                = var.name
  address_space       = var.cidr
  location            = var.resource_group.location
  resource_group_name = var.resource_group.name
}
