variable "cloudflare_token" {
  type        = string
  sensitive   = true
  description = "The Cloudflare API token"
}

variable "cloudflare_zone_id" {
  type        = string
  description = "The Cloudflare zone ID"
  sensitive   = true
}

variable "cloudflare_account_id" {
  type        = string
  description = "The Cloudflare account ID"
}

provider "cloudflare" {
  api_token = var.cloudflare_token
}

data "cloudflare_zone" "this" {
  zone_id = var.cloudflare_zone_id
}

resource "cloudflare_zone_setting" "https_only" {
  zone_id    = data.cloudflare_zone.this.zone_id
  setting_id = "always_use_https"
  value      = "on"
}

resource "cloudflare_zone_setting" "hsts" {
  zone_id    = data.cloudflare_zone.this.zone_id
  setting_id = "security_header"
  value = {
    strict_transport_security = {
      enabled            = true
      include_subdomains = true
      preload            = true
      nosniff            = true
      max_age            = 0
    }
  }
}

resource "cloudflare_zone_setting" "min_tls_version" {
  zone_id    = data.cloudflare_zone.this.zone_id
  setting_id = "min_tls_version"
  value      = "1.2"
}

resource "cloudflare_zone_setting" "ssl" {
  zone_id    = data.cloudflare_zone.this.zone_id
  setting_id = "ssl"
  value      = "full"
}

