variable "env_name" {
  type        = string
  description = "The name of the environment (eg. Production, Staging, etc.)"
}

locals {
  env_name = lower(var.env_name)
}
