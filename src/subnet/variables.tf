variable "name" {
  type        = string
  description = "Azure Subnet Name"
}

variable "cidrs" {
  type        = list(string)
  description = "IP Range list for Azure Subnet"
}

variable "vnet" {
  type = object({
    id   = string
    name = string
  })
  description = "Azure Virtual Network (VNET) Object"
}

variable "resource_group" {
  type = object({
    name     = string
    location = string
  })
  description = "Azure Resource Group"
}
