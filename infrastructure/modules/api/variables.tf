variable "project_id" {
  type        = string
  description = "The scaleway project ID"
}

variable "prefix" {
  type        = string
  description = "Prefix for the resources name"
}

variable "min_scale" {
  type        = number
  description = "The minimum scale for the API"
  default     = 0
}

variable "max_scale" {
  type        = number
  description = "The maximum scale for the API"
  default     = 1
}

variable "cpu_limit" {
  type        = number
  description = "The CPU limit for the API"
  default     = 100
}

variable "memory_limit" {
  type        = number
  description = "The memory limit for the API"
  default     = 128
}

variable "main_database_url" {
  type        = string
  description = "The main database URL"
  sensitive   = true
}

variable "api_key_rotation_days" {
  type        = number
  description = "The number of days before the API key rotates"
  default     = 30
}

variable "api_key_expiration_days" {
  type        = number
  description = "The number of days before the API key expires"
  default     = 90
}

variable "api_hostname" {
  type        = string
  description = "The API hostname"
}
