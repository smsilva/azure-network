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
  location               = "centralus"
}

module "platform" {
  source = "../"
}

module "vnet_example" {
  source = "../../src/vnet"

  platform_instance_name = local.platform_instance_name
  location               = local.location
  name                   = "vnet-example"
  cidrs                  = ["10.0.0.0/20"]
}

output "module_vnet_example_outputs" {
  value = module.vnet_example
}
