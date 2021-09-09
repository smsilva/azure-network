provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "example"
  location = "centralus"
}

module "vnet" {
  source = "../../src/vnet"

  name           = "vnet-hub"
  cidr           = ["10.0.0.0/20"]
  resource_group = azurerm_resource_group.example
}
