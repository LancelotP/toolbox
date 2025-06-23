output "api_registry_endpoint" {
  value = scaleway_container_namespace.api.registry_endpoint
}

output "web_registry_endpoint" {
  value = scaleway_container_namespace.web.registry_endpoint
}

output "github_actions_access_key" {
  value     = scaleway_iam_api_key.github_actions.access_key
  sensitive = true
}

output "github_actions_secret_key" {
  value     = scaleway_iam_api_key.github_actions.secret_key
  sensitive = true
}

output "github_actions_organization_id" {
  value = scaleway_account_project.this.organization_id
}

output "github_actions_project_id" {
  value = scaleway_account_project.this.id
}

output "api_container_id" {
  # Scaleway container ids are prefixed with the region
  value = split("/", scaleway_container.api.id)[1]
}
