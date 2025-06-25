locals {
  api_key_expiration = timeadd(
    time_rotating.api_key_rotation.rotation_rfc3339,
    "${(var.validity_days - var.rotation_days) * 24}h"
  )
}

resource "time_rotating" "api_key_rotation" {
  rotation_days = var.rotation_days
}

resource "scaleway_iam_api_key" "key" {
  application_id     = var.iam_app_id
  description        = var.key_description
  default_project_id = var.project_id
  expires_at         = local.api_key_expiration

  lifecycle {
    replace_triggered_by  = [time_rotating.api_key_rotation]
    create_before_destroy = true
  }
}
