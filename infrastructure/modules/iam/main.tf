resource "scaleway_iam_user" "developers" {
  for_each   = var.developers
  username   = each.key
  email      = each.value.email
  first_name = each.value.first_name
  last_name  = each.value.last_name

  send_welcome_email = true
}

resource "scaleway_iam_group" "developers" {
  name                = "developers-${var.environment}"
  description         = "Developers group for the ${var.environment} environment"
  external_membership = true
}

resource "scaleway_iam_group_membership" "developers" {
  for_each = scaleway_iam_user.developers
  group_id = scaleway_iam_group.developers.id
  user_id  = scaleway_iam_user.developers[each.key].id
}

resource "scaleway_iam_policy" "developers" {
  group_id    = scaleway_iam_group.developers.id
  name        = "developers-${var.environment}"
  description = "Allow developers to access the project for the ${var.environment} environment"

  rule {
    project_ids = [var.project_id]
    permission_set_names = [
      # Container
      "ContainerRegistryReadOnly",
      "ContainersReadOnly",
      # Object Storage
      "ObjectStorageBucketsRead",
      "ObjectStorageObjectsRead",
      "ObjectStorageReadOnly",
      # Databases
      "RedisReadOnly",
      "RelationalDatabasesReadOnly",
      "ServerlessSQLDatabaseReadOnly",
    ]
  }

  rule {
    organization_id = var.organization_id
    permission_set_names = [
      "NotificationManagerReadOnly",
      "OrganizationReadOnly",
      "ProjectReadOnly",
      "SupportTicketReadOnly",
      "AuditTrailReadOnly",
      "BillingReadOnly",
      "EnvironmentalImpactReadOnly",
      "IAMReadOnly",
    ]
  }
}
