resource "random_string" "vnet_id" {
  length      = 3
  min_numeric = 1
  min_lower   = 1
  special     = false
  upper       = false
}

locals {
  virtual_network_name     = "wasp-vnet-example-1-${random_string.vnet_id.result}"
  virtual_network_location = "centralus"
  virtual_network_cidrs    = ["10.0.0.0/8"]
}

resource "azurerm_resource_group" "default" {
  name     = local.virtual_network_name
  location = local.virtual_network_location
}

module "vnet" {
  source = "../../src/vnet"

  name                = local.virtual_network_name
  cidrs               = local.virtual_network_cidrs
  resource_group_name = azurerm_resource_group.default.name

  depends_on = [
    azurerm_resource_group.default
  ]
}

output "vnet_id" {
  value = module.vnet.instance.id
}
