variable "name" {
  description = "Azure Virtual Network (VNET) Name"
  type        = string
}

variable "resource_group_name" {
  description = "(Optional) Azure Virtual Network (VNET) Resource Group Name. If not informed, the module will try to use the Virtual Network Name."
  type        = string
}

variable "cidrs" {
  description = "Azure Virtual Network CIDR. Ex: 10.0.0.0/8"
  type        = list(string)
}

variable "subnets" {
  description = "Subnet Object List"
  type = list(object({
    cidr = string
    name = string
  }))
  default = []
}
