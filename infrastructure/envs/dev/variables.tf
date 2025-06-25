variable "scw_region" {
  type        = string
  description = "The Scaleway region"
  default     = "fr-par"
}

variable "scw_zone" {
  type        = string
  description = "The Scaleway zone"
  default     = "fr-par-2"
}

variable "scw_access_key" {
  type        = string
  description = "The Scaleway access key"
  sensitive   = true
}

variable "scw_secret_key" {
  type        = string
  description = "The Scaleway secret key"
  sensitive   = true
}

variable "scw_organization_id" {
  type        = string
  description = "The Scaleway organization ID"
  sensitive   = true
}

variable "scw_owner_id" {
  type        = string
  description = "The Scaleway owner ID"
  sensitive   = true
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

variable "github_access_token" {
  type        = string
  description = "The GitHub access token"
  sensitive   = true
}

variable "github_repo" {
  type        = string
  description = "The GitHub repository name"
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
