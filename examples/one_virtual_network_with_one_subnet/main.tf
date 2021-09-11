provider "azurerm" {
  features {}
}

locals {
  platform_instance_name  = "crow-sandbox-iq1"
  location                = "centralus"
  virtual_network_cidrs   = ["10.0.0.0/20"]
  virtual_network_subnets = [{ cidr = "10.0.1.0/29", name = "AzureBastionSubnet" }]
}

module "vnet_aks" {
  source = "../../src/vnet"

  platform_instance_name = local.platform_instance_name
  location               = local.location
  name                   = "vnet-aks"
  cidrs                  = local.virtual_network_cidrs
  subnets                = local.virtual_network_subnets
}

output "module_vnet_aks_outputs" {
  value = module.vnet_aks
}
