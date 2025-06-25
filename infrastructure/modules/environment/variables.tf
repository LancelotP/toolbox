variable "scw_region" {
  type        = string
  description = "The scaleway region"
  default     = "fr-par"
}

variable "scw_zone" {
  type        = string
  description = "The scaleway zone"
  default     = "fr-par-2"
}

variable "scw_access_key" {
  type        = string
  description = "The scaleway access key"
}

variable "scw_secret_key" {
  type        = string
  description = "The scaleway secret key"
  sensitive   = true
}

variable "scw_organization_id" {
  type        = string
  description = "The scaleway organization ID"
}

variable "scw_owner_id" {
  type        = string
  description = "The Scaleway owner ID"
  sensitive   = true
}

variable "github_access_token" {
  type        = string
  description = "The GitHub access token"
  sensitive   = true
}

variable "github_repo" {
  type        = string
  description = "The GitHub repository name"
}

variable "environment" {
  type        = string
  description = "Environment name"
}

variable "main_db_min_cpu" {
  type        = number
  description = "The minimum CPU for the main database"
  default     = 0
}

variable "main_db_max_cpu" {
  type        = number
  description = "The maximum CPU for the main database"
  default     = 1
}

variable "api_min_scale" {
  type        = number
  description = "The minimum scale for the API"
  default     = 0
}

variable "api_max_scale" {
  type        = number
  description = "The maximum scale for the API"
  default     = 1
}

variable "api_cpu_limit" {
  type        = number
  description = "The CPU limit for the API"
  default     = 100
}

variable "api_memory_limit" {
  type        = number
  description = "The memory limit for the API"
  default     = 128
}

variable "developers" {
  type = map(object({
    email      = string
    first_name = string
    last_name  = string
  }))
  description = "The developers to add to the IAM resources"
}

variable "api_subdomain" {
  type        = string
  description = "The API subdomain"
}

variable "cf_zone_id" {
  type        = string
  description = "The Cloudflare zone ID"
}

variable "cf_token" {
  type        = string
  description = "The Cloudflare API token"
  sensitive   = true
}
