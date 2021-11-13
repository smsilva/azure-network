variable "name" {
  type        = string
  description = "Azure Virtual Network (VNET) Name"
}

variable "resource_group_name" {
  type    = string
  default = ""
}

variable "location" {
  type        = string
  description = "Azure Location for Virtual Network"
}

variable "cidrs" {
  type        = list(string)
  description = "Azure Virtual Network CIDR. Ex: 10.0.0.0/8"
}

variable "subnets" {
  type = list(object({
    cidr = string
    name = string
  }))
  description = "Subnet Object List"
  default     = []
}
