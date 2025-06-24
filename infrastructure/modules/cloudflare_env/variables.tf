variable "environment" {
  type = string
}

variable "api_endpoint" {
  type        = string
  description = "The API endpoint to use in the DNS record"
}

variable "api_container_endpoint" {
  type        = string
  description = "The API container endpoint to point to"
}
