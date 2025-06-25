resource "github_repository_environment" "this" {
  environment = var.environment
  repository  = data.github_repository.this.name
}

resource "github_actions_environment_variable" "this" {
  for_each      = var.environment_variables
  environment   = github_repository_environment.this.environment
  repository    = data.github_repository.this.name
  variable_name = each.key
  value         = each.value
}

resource "github_actions_environment_secret" "this" {
  for_each        = nonsensitive(toset(keys(var.environment_secrets)))
  environment     = github_repository_environment.this.environment
  repository      = data.github_repository.this.name
  secret_name     = each.key
  plaintext_value = var.environment_secrets[each.key]
}

locals {
  secrets = sensitive({
    SCW_SECRET_KEY           = module.github_actions_credentials.secret_key
    SCW_REGISTRY_CREDENTIALS = module.github_actions_credentials.secret_key
  })

  variables = {
    SCW_ACCESS_KEY = module.github_actions_credentials.access_key
  }
}

resource "github_actions_environment_secret" "scw_credentials" {
  for_each        = nonsensitive(toset(keys(local.secrets)))
  environment     = github_repository_environment.this.environment
  repository      = data.github_repository.this.name
  secret_name     = each.key
  plaintext_value = local.secrets[each.key]
}

resource "github_actions_environment_variable" "scw_variables" {
  for_each      = local.variables
  environment   = github_repository_environment.this.environment
  repository    = data.github_repository.this.name
  variable_name = each.key
  value         = each.value
}

resource "scaleway_iam_application" "github_actions" {
  name        = "${var.prefix}-github-actions"
  description = "Github Actions application for the ${var.environment} environment"
}

module "github_actions_credentials" {
  source          = "../../utils/rotating-api-key"
  key_description = "Github Actions API key for the ${var.environment} environment"
  iam_app_id      = scaleway_iam_application.github_actions.id
  project_id      = var.project_id
  rotation_days   = 30
  validity_days   = 90
}

resource "scaleway_iam_policy" "github_actions" {
  name           = "${var.prefix}-github-actions"
  application_id = scaleway_iam_application.github_actions.id

  rule {
    project_ids = [var.project_id]
    permission_set_names = [
      "ContainerRegistryFullAccess",
      "ContainersFullAccess",
    ]
  }
}
