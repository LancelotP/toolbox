variable "env_name" {
  type        = string
  description = "The name of the environment (eg. Production, Staging, etc.)"
}

variable "api_endpoint" {
  type        = string
  description = "The API endpoint to point to"
}

locals {
  env_name = lower(var.env_name)
}
