resource "scaleway_account_project" "this" {
  name        = var.project_name
  description = "Project for the ${var.environment} environment"
}
