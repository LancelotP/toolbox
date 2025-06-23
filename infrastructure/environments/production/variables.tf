variable "access_key" {
  type      = string
  sensitive = true
}

variable "secret_key" {
  type      = string
  sensitive = true
}

variable "organization_id" {
  type      = string
  sensitive = true
}

variable "project_id" {
  type      = string
  sensitive = true
}

variable "github_access_token" {
  type        = string
  description = "GitHub Acces Token"
  sensitive   = true
}
