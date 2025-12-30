# 🔐 RBAC ACCESS (IMPORTANT PART)
resource "azurerm_role_assignment" "kv_access" {
  for_each = var.keyvault_assignments

  scope                = each.value.scope
  role_definition_name = each.value.role_name
  principal_id         = each.value.principal_id
}
