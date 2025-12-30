resource "azurerm_postgresql_flexible_server_firewall_rule" "fw" {
  for_each = var.firewall_rules

  name      = each.value.name
  server_id = var.postgres_server_ids[each.value.server_key]
  start_ip_address = each.value.start_ip
  end_ip_address   = each.value.end_ip
}
