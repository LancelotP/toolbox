output "db_main_connection_string" {
  value = format("postgres://%s:%s@%s",
    var.iam_api_app_id,
    var.iam_api_app_secret_key,
    trimprefix(scaleway_sdb_sql_database.main.endpoint, "postgres://"),
  )
  sensitive = true
}
