provider "azurerm" {
  features {}
}

locals {
  vnets = {
    "hub" = {
      name = "hub"
      cidr = "10.0.0.0/20"
      subnets = [
        { cidr = "10.0.1.0/29", name = "AzureBastionSubnet" },
        { cidr = "10.0.2.0/27", name = "snet-vpn-gateway" },
        { cidr = "10.0.3.0/29", name = "snet-firewall" },
      ]
    }
    "spokeone" = {
      name = "vnet-spoke-one"
      cidr = "10.100.0.0/16"
      subnets = [
        { cidr = "10.100.0.0/16", name = "snet-spoke-one-resources" },
      ]
    }
  }
}

resource "azurerm_resource_group" "example" {
  name     = "example"
  location = "centralus"
}

module "shared_network_configuration" {
  source         = "../../src/vnets"
  vnets          = local.vnets
  location       = azurerm_resource_group.example.location
  resource_group = azurerm_resource_group.example
}

output "results" {
  value = module.shared_network_configuration
}