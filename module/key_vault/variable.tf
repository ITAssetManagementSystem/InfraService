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
    kv_key = string # Must match a key in var.kv
  }))
}


variable "keyvault_assignments" {
  description = "Key Vault RBAC assignments"
  type = map(object({
    scope        = string # 👈 Key Vault ID passed from root
    role_name    = string
    principal_id = string
  }))
}





