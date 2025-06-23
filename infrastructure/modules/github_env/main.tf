terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "6.6.0"
    }
  }
}

resource "github_repository_environment" "environment" {
  environment = var.env_name
  repository  = var.github_repo
}

resource "github_actions_environment_variable" "web_registry_endpoint" {
  environment   = github_repository_environment.environment.environment
  repository    = github_repository_environment.environment.repository
  variable_name = "SCW_WEB_REGISTRY_ENDPOINT"
  value         = var.web_registry_endpoint
}

resource "github_actions_environment_variable" "api_registry_endpoint" {
  environment   = github_repository_environment.environment.environment
  repository    = github_repository_environment.environment.repository
  variable_name = "SCW_API_REGISTRY_ENDPOINT"
  value         = var.api_registry_endpoint
}

resource "github_actions_environment_secret" "scw_access_key" {
  environment     = github_repository_environment.environment.environment
  repository      = github_repository_environment.environment.repository
  secret_name     = "SCW_ACCESS_KEY"
  plaintext_value = var.scw_access_key
}

resource "github_actions_environment_secret" "scw_secret_key" {
  environment     = github_repository_environment.environment.environment
  repository      = github_repository_environment.environment.repository
  secret_name     = "SCW_SECRET_KEY"
  plaintext_value = var.scw_secret_key
}

resource "github_actions_environment_variable" "scw_organization_id" {
  environment   = github_repository_environment.environment.environment
  repository    = github_repository_environment.environment.repository
  variable_name = "SCW_ORGANIZATION_ID"
  value         = var.scw_organization_id
}

resource "github_actions_environment_variable" "scw_project_id" {
  environment   = github_repository_environment.environment.environment
  repository    = github_repository_environment.environment.repository
  variable_name = "SCW_PROJECT_ID"
  value         = var.scw_project_id
}

resource "github_actions_environment_variable" "api_container_id" {
  environment   = github_repository_environment.environment.environment
  repository    = github_repository_environment.environment.repository
  variable_name = "SCW_API_CONTAINER_ID"
  value         = var.scw_api_container_id
}
