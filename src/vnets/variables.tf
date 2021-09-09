variable "location" {
  default     = "centralus"
  description = "Azure Virtual Network (VNET) Location"
}

variable "resource_group" {
  type = object({
    name     = string
    location = string
  })
  description = "Azure Resource Group"
}

variable "vnets" {
  description = "Azure Virtual Network Composed List with Subnets"
  default     = []
}
