variable "environment" {
  type        = string
  description = "The environment to deploy the IAM resources to"
}

variable "project_id" {
  type        = string
  description = "The project ID to deploy the IAM resources to"
}

variable "organization_id" {
  type        = string
  description = "The organization ID to deploy the IAM resources to"
}

variable "developers" {
  type = map(object({
    email      = string
    first_name = string
    last_name  = string
  }))
  description = "The developers to add to the IAM resources"
}
