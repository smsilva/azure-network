provider "azurerm" {
  features {}
}

variable "platform_instance_name" {
  type    = string
  default = "wasp-sandbox-iq1"
}

locals {
  platform_instance_name  = var.platform_instance_name
  location                = "centralus"
  virtual_network_cidrs   = ["10.0.0.0/8"]
  virtual_network_subnets = [{ cidr = "10.140.0.0/16", name = "AzureBastionSubnet" }]
}

module "vnet_example" {
  source = "../../src/vnet"

  platform_instance_name = local.platform_instance_name
  location               = local.location
  name                   = "vnet-example"
  cidrs                  = local.virtual_network_cidrs
  subnets                = local.virtual_network_subnets
}

output "module_vnet_example_outputs" {
  value = module.vnet_example
}
