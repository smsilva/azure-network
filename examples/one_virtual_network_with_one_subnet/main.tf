provider "azurerm" {
  features {}
}

locals {
  name                    = "vnet-example"
  location                = "centralus"
  virtual_network_cidrs   = ["10.0.0.0/8"]
  virtual_network_subnets = [{ cidr = "10.140.0.0/16", name = "AzureBastionSubnet" }]
}

module "vnet_example" {
  source = "../../src/vnet"

  name     = local.name
  location = local.location
  cidrs    = local.virtual_network_cidrs
  subnets  = local.virtual_network_subnets
}

output "module_vnet_example_outputs" {
  value = module.vnet_example
}
