data "azurerm_key_vault_secret" "db_pass" {
  for_each     = var.postgres_sql
  name         = each.value.secret_name
  key_vault_id = var.key_vault_ids[each.value.kv_key]
}

resource "azurerm_postgresql_flexible_server" "postgres" {
  for_each                      = var.postgres_sql
  name                          = each.value.name
  resource_group_name           = each.value.resource_group_name
  location                      = each.value.location
  version                       = each.value.version
  public_network_access_enabled = true
  administrator_login           = each.value.admin_username
  administrator_password        = data.azurerm_key_vault_secret.db_pass[each.key].value
  sku_name                      = each.value.sku_name
  storage_mb                    = each.value.storage_mb

  # high_availability {
  #   mode                      = "ZoneRedundant"
  #   standby_availability_zone = "2"
  # }

}
