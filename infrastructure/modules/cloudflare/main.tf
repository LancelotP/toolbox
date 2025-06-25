provider "cloudflare" {
  api_token = var.token
}

resource "cloudflare_record" "api" {
  lifecycle {
    create_before_destroy = true
  }

  zone_id = data.cloudflare_zone.this.zone_id
  name    = var.api_subdomain
  type    = "CNAME"
  content = var.api_container_endpoint
  ttl     = 1
  proxied = true
}
