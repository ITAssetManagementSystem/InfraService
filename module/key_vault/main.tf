data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "kv" {
  for_each = var.kv

  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = "standard"

  rbac_authorization_enabled = true

  soft_delete_retention_days = 7
  purge_protection_enabled   = true
}

# 🔐 RBAC ACCESS (IMPORTANT PART)
resource "azurerm_role_assignment" "kv_access" {
  for_each             = var.keyvault_assignments
  depends_on           = [azurerm_key_vault.kv]
  scope                = each.value.scope
  role_definition_name = each.value.role_name
  principal_id         = each.value.principal_id
}

resource "azurerm_key_vault_secret" "sec" {
  for_each     = var.sec
  depends_on   = [azurerm_role_assignment.kv_access]
  name         = each.value.name
  value        = each.value.value
  key_vault_id = azurerm_key_vault.kv[each.value.kv_key].id
}


