
variable "keyvault_assignments" {
  description = "Key Vault RBAC assignments"
  type = map(object({
    scope        = string   # 👈 Key Vault ID passed from root
    role_name   = string
    principal_id = string
  }))
}


