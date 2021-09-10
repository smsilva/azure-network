output "vnet" {
  value = {
    id   = azurerm_virtual_network.default.id
    name = azurerm_virtual_network.default.name
  }
}

output "id" {
  value = azurerm_virtual_network.default.id
}

output "name" {
  value = azurerm_virtual_network.default.name
}

output "virtual_network" {
  value = azurerm_virtual_network.default
}

output "resource_group" {
  value = azurerm_resource_group.default
}
