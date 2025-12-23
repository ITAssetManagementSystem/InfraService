resource "azurerm_role_assignment" "acr_pull" {
  for_each = var.assignments

  scope                = each.value.acr_id
  role_definition_name = "AcrPull"
  principal_id         = each.value.kubelet_object_id
}
