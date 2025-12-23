output "postgres_server_ids" {
  description = "PostgreSQL Flexible Server IDs"
  value = {
    for k, v in azurerm_postgresql_flexible_server.postgres :
    k => v.id
  }
}
