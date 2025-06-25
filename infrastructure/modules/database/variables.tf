variable "project_id" {
  type        = string
  description = "The scaleway project ID"
}

variable "iam_api_app_id" {
  type        = string
  description = "The scaleway IAM application ID for the API"
}

variable "iam_api_app_secret_key" {
  type        = string
  description = "The scaleway IAM application secret key for the API IAM application"
  sensitive   = true
}

variable "prefix" {
  type        = string
  description = "Prefix for the resources name"
}

variable "min_cpu" {
  type        = number
  description = "The minimum CPU for the database"
  default     = 0
}

variable "max_cpu" {
  type        = number
  description = "The maximum CPU for the database"
  default     = 1
}
