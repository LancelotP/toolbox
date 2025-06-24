terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "5.6.0"
    }
  }
}

data "tfe_outputs" "global" {
  organization = "LancelotPOrg"
  workspace    = "global"
}

data "cloudflare_zone" "this" {
  zone_id = data.tfe_outputs.global.values.cf_zone_id
}

resource "cloudflare_dns_record" "api" {
  zone_id = data.cloudflare_zone.this.zone_id
  name    = var.api_endpoint
  type    = "CNAME"
  content = var.api_container_endpoint
  ttl     = 1
  proxied = true
}

output "api_endpoint" {
  value = cloudflare_dns_record.api.content
}
