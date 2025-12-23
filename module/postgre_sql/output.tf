output "postgres_server_ids" {
  value = {
    for k, v in azurerm_postgresql_flexible_server.postgres_sql :
    k => v.id
  }
}

