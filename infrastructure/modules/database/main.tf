locals {
  db_name = "${var.prefix}-db-main"
}

resource "scaleway_iam_policy" "main_db_access" {
  name           = "${local.db_name}-access"
  description    = "Policy to access the main database"
  application_id = var.iam_api_app_id

  rule {
    project_ids          = [var.project_id]
    permission_set_names = ["ServerlessSQLDatabaseReadWrite"]
  }
}

resource "scaleway_sdb_sql_database" "main" {
  lifecycle {
    create_before_destroy = true
  }

  project_id = var.project_id

  name    = local.db_name
  min_cpu = var.min_cpu
  max_cpu = var.max_cpu
}
