variable "platform_instance_name" {
  type        = string
  description = "Platform Instance Name"
}

variable "location" {
  default     = "centralus"
  description = "Azure Virtual Network (VNET) Location"
}

variable "vnets" {
  description = "Azure Virtual Network Composed List with Subnets"
}
