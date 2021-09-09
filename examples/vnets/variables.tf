variable "vnets" {
  default = {
    "hub" = {
      name = "hub"
      cidr = "10.0.0.0/20"
      subnets = [
        { cidr = "10.0.1.0/29", name = "AzureBastionSubnet" },
        { cidr = "10.0.2.0/27", name = "snet-vpn-gateway" },
        { cidr = "10.0.3.0/29", name = "snet-firewall" },
      ]
    }
    "spokeone" = {
      name = "vnet-spoke-one"
      cidr = "10.100.0.0/16"
      subnets = [
        { cidr = "10.100.0.0/16", name = "snet-spoke-one-resources" },
      ]
    }
  }
}
