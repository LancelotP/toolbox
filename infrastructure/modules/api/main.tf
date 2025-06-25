locals {
  namespace_name = "${var.prefix}-ns-api"
  container_name = "${var.prefix}-api"
  registry_name  = "${var.prefix}-api"
}

module "api_credentials" {
  source = "../../utils/rotating-api-key"

  iam_app_id      = scaleway_iam_application.api.id
  project_id      = var.project_id
  rotation_days   = var.api_key_rotation_days
  validity_days   = var.api_key_expiration_days
  key_description = "Key used by the API containers"
}

resource "scaleway_iam_application" "api" {
  name        = local.container_name
  description = "Application for the API"
}

resource "scaleway_container_namespace" "api" {
  name       = local.namespace_name
  project_id = var.project_id

  secret_environment_variables = {
    MAIN_DATABASE_URL = var.main_database_url
  }
}

resource "scaleway_container" "api" {
  name         = local.container_name
  namespace_id = scaleway_container_namespace.api.id

  # We ignore those changes because once the first image is deployed those values will change.
  registry_image = "traefik/whoami:latest"
  deploy         = true

  lifecycle {
    ignore_changes = [registry_image]
  }

  min_scale    = var.min_scale
  max_scale    = var.max_scale
  cpu_limit    = var.cpu_limit
  memory_limit = var.memory_limit

  http_option = "redirected"

  port = 80

  # TODO: Add a health check
  # TODO: Add a domain
}

resource "scaleway_container_domain" "api" {
  lifecycle {
    create_before_destroy = true
  }

  container_id = scaleway_container.api.id
  hostname     = var.api_hostname
}
