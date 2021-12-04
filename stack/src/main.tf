resource "random_string" "vnet_id" {
  length      = 3
  min_numeric = 1
  min_lower   = 1
  special     = false
  upper       = false
}

locals {
  virtual_network_name = "${var.virtual_network_name}-${random_string.vnet_id.result}"
  resource_group_name  = var.resource_group_name != "" ? var.resource_group_name : local.virtual_network_name
}

resource "azurerm_resource_group" "default" {
  name     = local.resource_group_name
  location = var.location
}

module "vnet_example" {
  source = "git@github.com:smsilva/azure-network.git//src/vnet?ref=3.0.3"

  name                = local.virtual_network_name
  cidrs               = var.virtual_network_cidrs
  subnets             = var.virtual_network_subnets
  resource_group_name = azurerm_resource_group.default.name

  depends_on = [
    azurerm_resource_group.default
  ]
}
