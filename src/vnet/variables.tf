variable "platform_instance_name" {
  type        = string
  description = "Platform Instance Name"
}

variable "name" {
  type        = string
  description = "Azure Virtual Network (VNET) Name"
}

variable "cidr" {
  type        = list(string)
  description = "Azure Virtual Network CIDR. Ex: 10.0.0.0/8"
}

variable "resource_group" {
  type = object({
    name     = string
    location = string
  })
  description = "Azure Resource Group for Virtual Network"
}
