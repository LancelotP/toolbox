variable "project_id" {
  type        = string
  description = "The Scaleway project ID"
}

variable "github_repo" {
  type        = string
  description = "The name of the github repository"
}

variable "environment" {
  type        = string
  description = "The name of the environment"
}

variable "prefix" {
  type        = string
  description = "The prefix for the resources"
}

variable "environment_variables" {
  type        = map(string)
  description = "The environment variables to set in the github repository"
}

variable "environment_secrets" {
  type        = map(string)
  description = "The environment secrets to set in the github repository"
  sensitive   = true
}
