resource "random_string" "vnet_id" {
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
  virtual_network_name = "${var.platform_instance_name}-${var.name}-${random_string.vnet_id.result}"

  subnets_map = {
    for subnet in var.subnets : subnet.name => subnet
  }
}

resource "azurerm_resource_group" "default" {
  name     = local.virtual_network_name
  location = var.location
}

resource "azurerm_virtual_network" "default" {
  name                = local.virtual_network_name
  address_space       = var.cidrs
  location            = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name
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
      id   = azurerm_resource_group.default.id
      name = azurerm_resource_group.default.name
    }
  }
}
