provider "azurerm" {
  features {}
}

# Secure traffic with a web application firewall (WAF)
# https://docs.microsoft.com/en-us/azure/aks/operator-best-practices-network#secure-traffic-with-a-web-application-firewall-waf

locals {
  virtual_network_location = "centralus"
  virtual_network_name     = "wasp-vnet-example-4"

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

resource "azurerm_resource_group" "default" {
  name     = local.virtual_network_name
  location = local.virtual_network_location
}

module "shared_network_configuration" {
  source = "../../src/vnets"

  name                = local.virtual_network_name
  vnets               = local.vnets
  resource_group_name = azurerm_resource_group.default.name

  depends_on = [
    azurerm_resource_group.default
  ]
}

output "shared_network_configuration_vnet_ids" {
  value = values(module.shared_network_configuration.vnets)[*].id
}

output "shared_network_configuration_vnet_keys" {
  value = keys(module.shared_network_configuration.vnets)
}

output "shared_network_configuration_subnets" {
  value = [
    for subnet in values(module.shared_network_configuration.subnets)[*].instance : {
      id   = subnet.id
      name = subnet.name
    }
  ]
}
