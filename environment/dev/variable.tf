variable "rg" {
  description = "Resource Group configuration map"
  type = map(object({
    name     = string
    location = string
  }))
}

variable "vnet" {

  type = map(object({
    name                = string
    resource_group_name = string
    location            = string
    address_space       = list(string)
  }))
}

variable "subnet" {
  description = "Subnet configuration map"
  type = map(object({
    name                 = string
    resource_group_name  = string
    virtual_network_name = string
    address_prefixes     = list(string)
  }))
}


variable "acr" {
  description = "Azure Container Registry configuration map"
  type = map(object({
    name                = string
    resource_group_name = string
    location            = string
    sku                 = string
    admin_enabled       = bool
  }))
}


variable "aks" {
  description = "AKS cluster configuration map"
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    dns_prefix          = string
    size                = string # VM size for node pool
  }))
}

variable "kv" {
  description = "Key Vault configuration map"
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
  }))
}

variable "sec" {
  description = "Key Vault secrets configuration map"
  type = map(object({
    name   = string
    value  = string
    kv_key = string   # Must match a key in var.kv
  }))
}
variable "keyvault_assignments" {
  type = map(object({
    principal_type = string
    kv_key         = string
  }))
}

variable "assignments" {
  type = map(object({
    acr_key = string
    aks_key = string
  }))
}

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

variable "postgres_db" {
  description = "PostgreSQL databases"
  type = map(object({
    db_name    = string
    server_key = string
  }))
}

variable "postgres_firewall_rules" {
  description = "PostgreSQL firewall rules"
  type = map(object({
    name       = string
    server_key = string
    start_ip   = string
    end_ip     = string
  }))
}
