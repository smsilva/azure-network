provider "azurerm" {
  features {}
}

locals {
  platform_instance_name = "crow-sandbox-iq1"
  location               = "centralus"

  subnets = [
    { cidr = "10.0.1.0/29", name = "AzureBastionSubnet" },
    { cidr = "10.0.2.0/27", name = "snet-vpn-gateway" },
    { cidr = "10.0.3.0/29", name = "snet-firewall" },
  ]

  subnets_map = {
    for subnet in local.subnets : subnet.name => subnet
  }
}

module "vnet_private" {
  source = "../../src/vnet"

  platform_instance_name = local.platform_instance_name
  location               = local.location
  name                   = "vnet-pvt"
  cidr                   = ["10.0.0.0/20"]
}

module "vnet_private_subnets" {
  for_each = local.subnets_map
  source   = "../../src/subnet"

  name  = each.value.name
  cidrs = [each.value.cidr]
  vnet  = module.vnet_private
}

output "module_vnet_private_outputs" {
  value = module.vnet_private
}

output "module_vnet_private_subnets_outputs" {
  value = module.vnet_private_subnets
}
