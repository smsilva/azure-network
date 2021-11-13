locals {
  virtual_network_cidrs = ["10.0.0.0/8"]
  virtual_network_subnets = [
    { cidr = "10.140.0.0/16", name = "AzureBastionSubnet" }
  ]
}
