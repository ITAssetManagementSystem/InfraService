resource "azurerm_postgresql_flexible_server_database" "db" {
  for_each  = var.postgres_db

  name      = each.value.db_name
  server_id = var.postgres_server_ids[each.value.server_key]

  charset   = "UTF8"
  collation = "en_US.utf8"
}
