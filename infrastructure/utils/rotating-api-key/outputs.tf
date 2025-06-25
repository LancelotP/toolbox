output "id" {
  value = scaleway_iam_api_key.key.id
}

output "secret_key" {
  value     = scaleway_iam_api_key.key.secret_key
  sensitive = true
}

output "access_key" {
  value = scaleway_iam_api_key.key.access_key
}
