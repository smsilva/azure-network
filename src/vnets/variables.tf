variable "name" {
  type        = string
  description = "Azure Virtual Network (VNET) Name"
}

variable "resource_group_name" {
  type = string
}

variable "vnets" {
  description = "Azure Virtual Network Composed List with Subnets"
}
