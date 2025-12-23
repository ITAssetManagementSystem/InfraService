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
