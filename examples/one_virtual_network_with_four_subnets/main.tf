provider "azurerm" {
  features {}
}

resource "random_string" "platform_instance_id" {
  length      = 3
  min_numeric = 1
  special     = false
  upper       = false
}

locals {
  platform_instance_name = "crow-sandbox-${random_string.platform_instance_id.result}"

  virtual_network_location = "centralus"
  virtual_network_name     = "vnet-example"
  virtual_network_cidrs    = ["10.0.0.0/8"]

  subnets = [
    { cidr = "10.0.1.0/29", name = "AzureBastionSubnet" },
    { cidr = "10.0.2.0/27", name = "vpn-gateway" },
    { cidr = "10.0.3.0/29", name = "firewall" },
    { cidr = "10.240.0.0/16", name = "aks" },
  ]
}

module "vnet_example" {
  source = "../../src/vnet"

  platform_instance_name = local.platform_instance_name
  location               = local.virtual_network_location
  name                   = local.virtual_network_name
  cidrs                  = local.virtual_network_cidrs
  subnets                = local.subnets
}

output "module_vnet_example_outputs" {
  value = module.vnet_example
}