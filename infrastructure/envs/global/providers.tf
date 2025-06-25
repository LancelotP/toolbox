terraform {
  required_providers {
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
      name = "global"
    }
  }
}
