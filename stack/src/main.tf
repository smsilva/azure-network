resource "random_string" "vnet_id" {
  length      = 3
  min_numeric = 1
  min_lower   = 1
  special     = false
  upper       = false
}

locals {
  virtual_network_name  = "${var.name}-${random_string.example.result}"
  virtual_network_cidrs = ["10.0.0.0/8"]
  virtual_network_subnets = [
    { cidr = "10.140.0.0/16", name = "AzureBastionSubnet" }
  ]

  resource_group_name = var.resource_group_name != "" ? var.resource_group_name : local.virtual_network_name
}

resource "azurerm_resource_group" "default" {
  name     = local.resource_group_name
  location = var.location
}

module "vnet_example" {
  source = "git@github.com:smsilva/azure-network.git//src/vnet?ref=3.0.3"

  name                = var.name
  cidrs               = local.virtual_network_cidrs
  subnets             = local.virtual_network_subnets
  resource_group_name = data.azurerm_resource_group.default.name
}
