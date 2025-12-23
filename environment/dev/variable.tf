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

variable "postgres_sql" {
  description = "PostgreSQL Flexible Server (public access)"
  type = map(object({
    name                = string
    resource_group_name = string
    location            = string
    version             = string

    admin_username = string
    admin_password = string

    #zone                = string
    storage_mb   = number
    storage_tier = string
    sku_name     = string
  }))
}

variable "postgres_db" {
  description = "PostgreSQL databases"
  type = map(object({
    db_name    = string
    server_key = string
  }))
}
