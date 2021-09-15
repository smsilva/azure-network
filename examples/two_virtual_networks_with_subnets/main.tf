provider "azurerm" {
  features {}
}

variable "platform_instance_name" {
  type    = string
  default = "wasp-sandbox-iq1"
}

locals {
  platform_instance_name = var.platform_instance_name
  location               = "centralus"

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

module "shared_network_configuration" {
  source = "../../src/vnets"

  platform_instance_name = local.platform_instance_name
  vnets                  = local.vnets
  location               = local.location
}

output "shared_network_configuration_vnet_ids" {
  value = values(module.shared_network_configuration.vnets)[*].id
}

output "shared_network_configuration_vnet_keys" {
  value = keys(module.shared_network_configuration.vnets)
}

output "shared_network_configuration_vnet_map" {
  value = module.shared_network_configuration.vnets
}
