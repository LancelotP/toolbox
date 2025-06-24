output "cf_api_endpoint" {
  value = cloudflare_dns_record.api.name
}
