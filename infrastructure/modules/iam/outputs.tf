output "developer_ids" {
  value = toset(values(scaleway_iam_user.developers)[*].id)
}
