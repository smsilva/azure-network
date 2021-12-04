variable "virtual_network_name" {
  type        = string
  description = "Azure Virtual Network (vnet) Name"
}

variable "location" {
  type        = string
  description = "Azure Region"
  default     = "eastus2"
}

variable "virtual_network_cidrs" {
  type        = list(string)
  description = "Azure Virtual Network CIDR. Ex: 10.0.0.0/8"
}

variable "virtual_network_subnets" {
  type = list(object({
    cidr = string
    name = string
  }))
  description = "Subnet Object List"
  default     = []
}

variable "resource_group_name" {
  type        = string
  description = "Azure Virtual Network (vnet) Resource Group Name"
  default     = ""
}
