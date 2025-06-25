locals {
  environment = "dev"
}

module "environment" {
  source = "../../modules/environment"

  environment   = local.environment
  api_subdomain = var.api_subdomain

  scw_region          = var.scw_region
  scw_zone            = var.scw_zone
  scw_access_key      = var.scw_access_key
  scw_secret_key      = var.scw_secret_key
  scw_organization_id = var.scw_organization_id
  scw_owner_id        = var.scw_owner_id

  github_repo         = var.github_repo
  github_access_token = var.github_access_token

  developers = var.developers

  cf_zone_id = var.cf_zone_id
  cf_token   = var.cf_token
}
