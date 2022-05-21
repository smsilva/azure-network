resource "random_string" "vnet_id" {
  length      = 3
  min_numeric = 1
  min_lower   = 1
  special     = false
  upper       = false
}

locals {
  virtual_network_name     = "wasp-vnet-example-3-${random_string.vnet_id.result}"
  virtual_network_location = "centralus"
  virtual_network_cidrs    = ["10.0.0.0/8"]

  subnets = [
    { cidr = "10.0.1.0/29", name = "AzureBastionSubnet" },
    { cidr = "10.0.2.0/27", name = "vpn-gateway" },
    { cidr = "10.0.3.0/29", name = "firewall" },
    { cidr = "10.240.0.0/16", name = "aks" },
  ]
}

resource "azurerm_resource_group" "default" {
  name     = local.virtual_network_name
  location = local.virtual_network_location
}

module "vnet" {
  source = "../../src/vnet"

  name                = local.virtual_network_name
  cidrs               = local.virtual_network_cidrs
  subnets             = local.subnets
  resource_group_name = azurerm_resource_group.default.name

  depends_on = [
    azurerm_resource_group.default
  ]
}

output "vnet_id" {
  value = module.vnet.instance.id
}

output "subnet_aks_id" {
  value = module.vnet.subnets["aks"].instance.id
}
