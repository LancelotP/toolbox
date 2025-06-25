output "iam_api_app_id" {
  value       = scaleway_iam_application.api.id
  description = "The Scaleway IAM application ID for the API"
}

output "iam_api_app_access_key" {
  value       = module.api_credentials.access_key
  description = "The Scaleway IAM application access key for the API"
  sensitive   = true
}

output "iam_api_app_secret_key" {
  value       = module.api_credentials.secret_key
  description = "The Scaleway IAM application secret key for the API"
  sensitive   = true
}

output "api_container_id" {
  # Scaleway container ids are prefixed with the region
  value = split("/", scaleway_container.api.id)[1]
}

output "api_registry_endpoint" {
  value = scaleway_container_namespace.api.registry_endpoint
}

output "api_container_endpoint" {
  value = scaleway_container.api.domain_name
}
