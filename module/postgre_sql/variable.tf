variable "postgres_sql" {
  description = "PostgreSQL Flexible Server (public access)"
  type = map(object({
    name                = string
    resource_group_name = string
    location            = string
    version             = string
    admin_username      = string
    admin_password      = string
    #zone                = string
    storage_mb          = number
    storage_tier        = string
    sku_name            = string
  }))
}



