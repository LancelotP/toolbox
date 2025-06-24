variable "scw_access_key" {
  type      = string
  sensitive = true
}

variable "scw_secret_key" {
  type      = string
  sensitive = true
}

variable "scw_organization_id" {
  type      = string
  sensitive = true
}

variable "github_access_token" {
  type        = string
  description = "GitHub Acces Token"
  sensitive   = true
}

variable "cloudflare_token" {
  type        = string
  description = "Cloudflare Token"
  sensitive   = true
}
