variable "postgres_sql" {
  type = map(object({
    name                = string
    resource_group_name = string
    location            = string
    version             = string
    admin_username = string
    secret_name    = string
    kv_key         = string
    sku_name   = string
    storage_mb = number
  }))
}


variable "key_vault_ids" {
  description = "Map of Key Vault IDs"
  type        = map(string)
}




