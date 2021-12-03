output "id" {
  value = module.vnet_example.id
}

output "instance" {
  value     = module.vnet_example.instance
  sensitive = true
}
