terraform {
  required_providers {
    scaleway = {
      source  = "scaleway/scaleway"
      version = "2.55.0"
    }

    github = {
      source  = "integrations/github"
      version = "6.6.0"
    }

    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "5.6.0"
    }
  }

  cloud {
    organization = "LancelotPOrg"

    workspaces {
      name = "production"
    }
  }
}

data "tfe_outputs" "global" {
  organization = "LancelotPOrg"
  workspace    = "global"
}

provider "github" {
  owner = "lancelotp"
  token = var.github_access_token
}

provider "scaleway" {
  region          = "fr-par"
  zone            = "fr-par-1"
  access_key      = var.scw_access_key
  secret_key      = var.scw_secret_key
  organization_id = var.scw_organization_id
}

provider "cloudflare" {
  api_token = var.cloudflare_token
}

locals {
  domain_name  = "prigent.dev"
  env_name     = "production"
  api_endpoint = "api.${local.domain_name}"
  app_endpoint = "app.${local.domain_name}"
}

module "scaleway_env" {
  source = "../../modules/scaleway_env"

  env_name     = local.env_name
  api_endpoint = module.cloudflare_env.cf_api_endpoint
}

module "cloudflare_env" {
  source = "../../modules/cloudflare_env"

  environment            = local.env_name
  api_endpoint           = local.api_endpoint
  api_container_endpoint = module.scaleway_env.api_container_endpoint
}

module "github_env" {
  source = "../../modules/github_env"

  env_name              = local.env_name
  api_registry_endpoint = module.scaleway_env.api_registry_endpoint
  web_registry_endpoint = module.scaleway_env.web_registry_endpoint
  scw_access_key        = module.scaleway_env.github_actions_access_key
  scw_secret_key        = module.scaleway_env.github_actions_secret_key
  scw_organization_id   = module.scaleway_env.github_actions_organization_id
  scw_project_id        = module.scaleway_env.github_actions_project_id
  scw_api_container_id  = module.scaleway_env.api_container_id

  github_repo = data.tfe_outputs.global.values.repository_name
}
