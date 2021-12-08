provider "azurerm" {
  features {}
}

locals {
  virtual_network_name  = "wasp-vnet-example-1"
  location              = "centralus"
  virtual_network_cidrs = ["10.0.0.0/8"]
}

resource "azurerm_resource_group" "default" {
  name     = local.virtual_network_name
  location = "eastus2"
}

module "vnet_example" {
  source = "../../src/vnet"

  name                = local.virtual_network_name
  cidrs               = local.virtual_network_cidrs
  resource_group_name = azurerm_resource_group.default.name

  depends_on = [
    azurerm_resource_group.default
  ]
}

output "module_vnet_example_outputs" {
  value = module.vnet_example
}
