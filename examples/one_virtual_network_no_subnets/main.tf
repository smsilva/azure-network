provider "azurerm" {
  features {}
}

locals {
  platform_instance_name = "crow-sandbox-iq1"
  location               = "centralus"
}

module "vnet_hub_example" {
  source = "../../src/vnet"

  platform_instance_name = local.platform_instance_name
  location               = local.location
  name                   = "vnet-hub"
  cidr                   = ["10.0.0.0/20"]
}

output "module_vnet_hub_example_outputs" {
  value = module.vnet_hub_example
}
