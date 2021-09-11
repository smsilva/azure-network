variable "platform_instance_name" {
  type        = string
  description = "Platform Instance Base Name"
  default     = "squid-sandbox"
}

resource "random_string" "platform_instance_id" {
  keepers = {
    platform_instance_name = var.platform_instance_name
  }

  length      = 3
  min_numeric = 1
  special     = false
  upper       = false
}

output "platform_instance_name" {
  value = "squid-sandbox-${random_string.platform_instance_id.result}"
}
