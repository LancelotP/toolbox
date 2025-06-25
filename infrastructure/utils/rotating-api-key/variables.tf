variable "iam_app_id" {
  description = "ID of the application attached to the api key"
  type        = string
}

variable "key_description" {
  description = "The description of the iam api key"
  type        = string
  nullable    = true
}

variable "project_id" {
  description = "The project_id you want to attach the resource to"
  type        = string
}

variable "rotation_days" {
  description = "Number of days between key rotations"
  type        = number
  default     = 30
}

variable "validity_days" {
  description = "Number of days the key remains valid"
  type        = number
  default     = 90
}
