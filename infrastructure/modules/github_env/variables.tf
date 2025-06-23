variable "env_name" {
  type        = string
  description = "The name of the environment (eg. Production, Staging, etc.)"
}

variable "github_repo" {
  type        = string
  description = "The GitHub repository"
}

variable "api_registry_endpoint" {
  type        = string
  description = "The API docker registry endpoint"
}

variable "web_registry_endpoint" {
  type        = string
  description = "The web docker registry endpoint"
}

variable "scw_access_key" {
  type        = string
  description = "The Scaleway access key for the environment"
  sensitive   = true
}

variable "scw_secret_key" {
  type        = string
  description = "The Scaleway secret key for the environment"
  sensitive   = true
}
