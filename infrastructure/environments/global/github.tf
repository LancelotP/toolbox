terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "6.6.0"
    }
  }

  cloud {
    organization = "LancelotPOrg"

    workspaces {
      name = "global"
    }
  }
}

variable "github_access_token" {
  type        = string
  description = "GitHub Access Token"
  sensitive   = true
}

provider "github" {
  owner = "lancelotp"
  token = var.github_access_token
}

resource "github_repository" "this" {
  name                 = "toolbox"
  is_template          = false
  description          = "A monorepo template with NestJS, React, React Native, and more. Powered by Nx."
  visibility           = "public"
  vulnerability_alerts = true

  topics = [
    "nx",
    "nestjs",
    "react",
    # "react-native",
    "tailwindcss",
    "typescript",
  ]

  allow_merge_commit = false
  allow_rebase_merge = false
  allow_squash_merge = true

  squash_merge_commit_title   = "PR_TITLE"
  squash_merge_commit_message = "COMMIT_MESSAGES"

  allow_auto_merge       = true
  allow_update_branch    = true
  delete_branch_on_merge = true

  has_issues      = true
  has_projects    = false
  has_discussions = false
  has_downloads   = false
  has_wiki        = false
}

resource "github_branch" "main" {
  repository = github_repository.this.name
  branch     = "main"
}

resource "github_branch_default" "main" {
  repository = github_repository.this.name
  branch     = "main"
}

resource "github_repository_ruleset" "default_branch" {
  name        = "default_branch_ruleset"
  repository  = github_repository.this.name
  target      = "branch"
  enforcement = "active"

  conditions {
    ref_name {
      exclude = []
      include = [
        "~DEFAULT_BRANCH"
      ]
    }
  }

  rules {
    deletion         = true
    non_fast_forward = true

    required_status_checks {
      strict_required_status_checks_policy = true

      required_check {
        context = "CI"
      }
    }
  }
}

output "repository_name" {
  value = github_repository.this.name
}
