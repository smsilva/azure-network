data "azurerm_resource_group" "default" {
  name = var.resource_group_name != "" ? var.resource_group_name : var.name
}

locals {
  virtual_network_cidrs = ["10.0.0.0/8"]
  virtual_network_subnets = [
    { cidr = "10.140.0.0/16", name = "AzureBastionSubnet" }
  ]
}

module "vnet_example" {
  source = "git@github.com:smsilva/azure-network.git//src/vnet?ref=main"

  name                = var.name
  location            = var.location
  cidrs               = local.virtual_network_cidrs
  subnets             = local.virtual_network_subnets
  resource_group_name = data.azurerm_resource_group.default.name
}
