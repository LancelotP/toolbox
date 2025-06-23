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
  access_key      = var.swc_access_key
  secret_key      = var.swc_secret_key
  organization_id = var.swc_organization_id
}

module "scaleway_env" {
  source = "../../modules/scaleway_env"

  env_name = "production"
}

module "github_env" {
  source = "../../modules/github_env"

  env_name              = "production"
  api_registry_endpoint = module.scaleway_env.api_registry_endpoint
  web_registry_endpoint = module.scaleway_env.web_registry_endpoint
  scw_access_key        = module.scaleway_env.github_actions_access_key
  scw_secret_key        = module.scaleway_env.github_actions_secret_key

  github_repo = data.tfe_outputs.global.values.repository_name
}
