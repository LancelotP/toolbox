variable "organization_id" {
  type        = string
  description = "The scaleway organization ID"
}

variable "owner_id" {
  type        = string
  description = "The scaleway owner ID"
}

variable "project_id" {
  type        = string
  description = "The scaleway project ID"
}

variable "region" {
  type        = string
  description = "The scaleway region"
}

variable "zone" {
  type        = string
  description = "The scaleway zone"
}

variable "prefix" {
  type        = string
  description = "Prefix for the resources name"
}

variable "iam_api_app_id" {
  type        = string
  description = "The scaleway IAM application ID for the API"
}

variable "iam_api_app_access_key" {
  type        = string
  description = "The scaleway IAM application access key for the API"
  sensitive   = true
}

variable "iam_api_app_secret_key" {
  type        = string
  description = "The scaleway IAM application secret key for the API"
  sensitive   = true
}

variable "developer_ids" {
  type        = set(string)
  description = "The IDs of the developers to add to the IAM resources"
}
