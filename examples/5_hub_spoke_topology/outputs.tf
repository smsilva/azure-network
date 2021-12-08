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
