locals {
  vnets = flatten([
    for key in keys(var.vnets) : [
      {
        name = key
        cidr = var.vnets[key].cidr
      }
    ]
  ])

  subnets = flatten([
    for key in keys(var.vnets) : [
      for subnet in var.vnets[key].subnets : {
        name = subnet.name
        cidr = subnet.cidr
        vnet = {
          name = key
          cidr = var.vnets[key].cidr
        }
      }
    ]
  ])

  vnets_map = {
    for vnet in local.vnets : vnet.name => vnet
  }

  subnets_map = {
    for subnet in local.subnets : subnet.name => subnet
  }
}

module "vnets" {
  for_each = local.vnets_map
  source   = "../vnet"

  platform_instance_name = var.platform_instance_name
  location               = var.location
  name                   = each.value.name
  cidrs                  = [each.value.cidr]
}

module "subnets" {
  for_each = local.subnets_map
  source   = "../subnet"

  name  = each.value.name
  cidrs = [each.value.cidr]
  vnet  = module.vnets[each.value.vnet.name]
}
