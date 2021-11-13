locals {
  virtual_network_cidrs = ["10.0.0.0/8"]
  virtual_network_subnets = [
    { cidr = "10.140.0.0/16", name = "AzureBastionSubnet" }
  ]

  resource_group_name = var.resource_group_name != "" ? var.resource_group_name : var.name
}

data "azurerm_resource_group" "default" {
  name = local.resource_group_name
}

module "vnet_example" {
  source = "git@github.com:smsilva/azure-network.git//src/vnet?ref=3.0.1"

  name                = var.name
  cidrs               = local.virtual_network_cidrs
  subnets             = local.virtual_network_subnets
  resource_group_name = data.azurerm_resource_group.default.name
}
