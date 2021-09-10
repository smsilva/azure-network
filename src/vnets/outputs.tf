output "locals" {
  value = {
    vnets = local.vnets
    snets = local.subnets
  }
}

output "vnets" {
  value = module.vnets
}

output "subnets" {
  value = module.subnets
}
