locals {
  virtual_network_name = var.name
  resource_group_name  = var.resource_group_name != "" ? var.resource_group_name : var.name

  subnets_map = {
    for subnet in var.subnets : subnet.name => subnet
  }
}

data "azurerm_resource_group" "default" {
  name = local.resource_group_name
}

resource "azurerm_virtual_network" "default" {
  name                = local.virtual_network_name
  address_space       = var.cidrs
  location            = data.azurerm_resource_group.default.location
  resource_group_name = data.azurerm_resource_group.default.name
}

module "subnets" {
  for_each = local.subnets_map
  source   = "../subnet"

  name  = each.value.name
  cidrs = [each.value.cidr]
  vnet = {
    id   = azurerm_virtual_network.default.id
    name = azurerm_virtual_network.default.name
    resource_group = {
      id   = data.azurerm_resource_group.default.id
      name = data.azurerm_resource_group.default.name
    }
  }
}
