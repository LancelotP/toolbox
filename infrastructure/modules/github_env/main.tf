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
  variable_name = "SWC_WEB_REGISTRY_ENDPOINT"
  value         = var.web_registry_endpoint
}

resource "github_actions_environment_variable" "api_registry_endpoint" {
  environment   = github_repository_environment.environment.environment
  repository    = github_repository_environment.environment.repository
  variable_name = "SCW_API_REGISTRY_ENDPOINT"
  value         = var.api_registry_endpoint
}

resource "github_actions_environment_secret" "registry_token" {
  environment     = github_repository_environment.environment.environment
  repository      = github_repository_environment.environment.repository
  secret_name     = "SCW_REGISTRY_TOKEN"
  plaintext_value = var.scw_access_key
}

resource "github_actions_environment_secret" "scw_secret_key" {
  environment     = github_repository_environment.environment.environment
  repository      = github_repository_environment.environment.repository
  secret_name     = "SCW_SECRET_KEY"
  plaintext_value = var.scw_secret_key
}
