resource "azurerm_postgresql_flexible_server" "postgres_sql" {
  for_each            = var.postgres_sql

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location

  administrator_login    = each.value.admin_username
  administrator_password = each.value.admin_password

  version      = each.value.version
  sku_name     = each.value.sku_name 
  storage_mb  = each.value.storage_mb 
  storage_tier = each.value.storage_tier
}
