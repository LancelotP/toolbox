terraform {
  required_providers {
    scaleway = {
      source  = "scaleway/scaleway"
      version = "2.55.0"
    }
  }
}

resource "scaleway_account_project" "this" {
  name = "${local.env_name}-toolbox"
}

resource "scaleway_container_namespace" "api" {
  name       = "toolbox-${local.env_name}-api"
  project_id = scaleway_account_project.this.id
}

resource "scaleway_container_namespace" "web" {
  name       = "toolbox-${local.env_name}-web"
  project_id = scaleway_account_project.this.id
}

resource "scaleway_iam_application" "github_actions" {
  name        = "${local.env_name}-github-actions"
  description = "Github Actions application for the ${local.env_name} environment"
}

resource "scaleway_iam_api_key" "github_actions" {
  application_id     = scaleway_iam_application.github_actions.id
  default_project_id = scaleway_account_project.this.id

  description = "Github Actions API key for the ${local.env_name} environment"
}

resource "scaleway_iam_policy" "github_actions" {
  name           = "${local.env_name}-github-actions"
  application_id = scaleway_iam_application.github_actions.id

  rule {
    project_ids = [scaleway_account_project.this.id]
    permission_set_names = [
      "ContainerRegistryFullAccess",
      "ContainersFullAccess"
    ]
  }
}

resource "scaleway_container" "api" {
  name         = "toolbox-${local.env_name}-api"
  namespace_id = scaleway_container_namespace.api.id

  # We ignore those changes because once the first image is deployed those values will change.
  registry_image = "hub.docker.com/traefik/whoami:latest"
  deploy         = false

  lifecycle {
    ignore_changes = [
      registry_image,
      deploy
    ]
  }

  min_scale   = 0
  max_scale   = 1
  http_option = "redirected"

  cpu_limit    = 100
  memory_limit = 128
  port         = 4000
}

resource "scaleway_container_domain" "api" {
  container_id = scaleway_container.api.id
  hostname     = var.api_endpoint
}
