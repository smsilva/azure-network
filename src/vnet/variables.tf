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

variable "location" {
  type        = string
  description = "Azure Location for Virtual Network"
}

variable "subnets" {
  type = list(object({
    cidir = string
    name  = string
  }))
  description = "Subnet Object List"
}
