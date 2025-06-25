locals {
  project_name = "tbox-${var.environment}"
}

module "project" {
  source       = "../project"
  environment  = var.environment
  project_name = local.project_name
}

module "database" {
  source                 = "../database"
  project_id             = module.project.project_id
  iam_api_app_id         = module.api.iam_api_app_id
  iam_api_app_secret_key = module.api.iam_api_app_secret_key
  prefix                 = local.project_name
  min_cpu                = var.main_db_min_cpu
  max_cpu                = var.main_db_max_cpu
}

module "api" {
  source            = "../api"
  project_id        = module.project.project_id
  prefix            = local.project_name
  min_scale         = var.api_min_scale
  max_scale         = var.api_max_scale
  cpu_limit         = var.api_cpu_limit
  memory_limit      = var.api_memory_limit
  main_database_url = module.database.db_main_connection_string
  api_hostname      = module.cloudflare.api_hostname
}

module "storage" {
  source          = "../storage"
  organization_id = var.scw_organization_id
  owner_id        = var.scw_owner_id
  project_id      = module.project.project_id
  region          = var.scw_region
  zone            = var.scw_zone

  iam_api_app_id         = module.api.iam_api_app_id
  iam_api_app_access_key = module.api.iam_api_app_access_key
  iam_api_app_secret_key = module.api.iam_api_app_secret_key
  developer_ids          = module.iam.developer_ids
  prefix                 = local.project_name
}

module "iam" {
  source          = "../iam"
  environment     = var.environment
  project_id      = module.project.project_id
  organization_id = var.scw_organization_id
  developers      = var.developers
}

module "github" {
  source      = "../github"
  github_repo = var.github_repo
  environment = var.environment
  project_id  = module.project.project_id
  prefix      = local.project_name

  environment_variables = {
    SCW_PROJECT_ID            = module.project.project_id
    SCW_API_REGISTRY_ENDPOINT = module.api.api_registry_endpoint
    SCW_API_CONTAINER_ID      = module.api.api_container_id
  }

  environment_secrets = {}
}

module "cloudflare" {
  source                 = "../cloudflare"
  zone_id                = var.cf_zone_id
  token                  = var.cf_token
  api_subdomain          = var.api_subdomain
  api_container_endpoint = module.api.api_container_endpoint
}
