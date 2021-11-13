variable "name" {
  type        = string
  description = "Azure Virtual Network (VNET) Name"
}

variable "location" {
  default     = "centralus"
  description = "Azure Virtual Network (VNET) Location"
}

variable "vnets" {
  description = "Azure Virtual Network Composed List with Subnets"
}
