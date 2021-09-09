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
