data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "kv" {
  for_each = var.kv

  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = "standard"

  soft_delete_retention_days = 7
}

resource "azurerm_key_vault_secret" "sec" {
  for_each = var.sec

  name         = each.value.name
  value        = each.value.value
  key_vault_id = azurerm_key_vault.kv[each.value.kv_key].id
}




