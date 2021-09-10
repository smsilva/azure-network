provider "azurerm" {
  features {}
}

locals {
  subnets = [
    { cidr = "10.0.1.0/29", name = "AzureBastionSubnet" },
    { cidr = "10.0.2.0/27", name = "snet-vpn-gateway" },
    { cidr = "10.0.3.0/29", name = "snet-firewall" },
  ]

  subnets_map = {
    for subnet in local.subnets : subnet.name => subnet
  }
}

resource "azurerm_resource_group" "example" {
  name     = "example"
  location = "centralus"
}

module "vnet_hub_example" {
  source = "../../src/vnet"

  name           = "vnet-hub"
  cidr           = ["10.0.0.0/20"]
  resource_group = azurerm_resource_group.example
}

module "vnet_hub_example_subnets" {
  for_each       = local.subnets_map
  source         = "../../src/subnet"
  name           = each.value.name
  cidrs          = [each.value.cidr]
  vnet           = module.vnet
  resource_group = azurerm_resource_group.example
}

output "module_vnet_hub_example_outputs" {
  value = module.vnet_hub_example
}

output "module_vnet_hub_example_subnets_outputs" {
  value = module.vnet_hub_example_subnets
}
