provider "azurerm" {
  features {}
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

output "module_vnet_hub_example_outputs" {
  value = module.vnet_hub_example
}
