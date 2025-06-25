terraform {
  required_providers {
    scaleway = {
      source  = "scaleway/scaleway"
      version = "2.56.0"
    }
  }

  cloud {
    organization = "LancelotPOrg"

    workspaces {
      name = "dev"
    }
  }
}

provider "scaleway" {
  region          = var.scw_region
  zone            = var.scw_zone
  access_key      = var.scw_access_key
  secret_key      = var.scw_secret_key
  organization_id = var.scw_organization_id
}
