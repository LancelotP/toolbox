variable "zone_id" {
  type        = string
  description = "The Cloudflare zone ID"
}

variable "token" {
  type        = string
  description = "The Cloudflare API token"
  sensitive   = true
}

variable "api_subdomain" {
  type        = string
  description = "The API subdomain to be used in the DNS record"
}

variable "api_container_endpoint" {
  type        = string
  description = "The API container endpoint the DNS record will point to"
}
