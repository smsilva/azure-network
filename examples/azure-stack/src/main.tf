module "vnet_example" {
  source = "git@github.com:smsilva/azure-network.git//src/vnet?ref=main"

  name     = var.name
  location = var.location
  cidrs    = local.virtual_network_cidrs
  subnets  = local.virtual_network_subnets
}
