output "key_vault_ids" {
  description = "Key Vault IDs"
  value = {
    for k, v in azurerm_key_vault.kv :
    k => v.id
  }
}

output "secret_ids" {
  value = { for k, v in azurerm_key_vault_secret.sec : k => v.id }
}
