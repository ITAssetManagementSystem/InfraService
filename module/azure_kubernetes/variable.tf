variable "aks" {
  description = "AKS cluster configuration map"
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    dns_prefix          = string
    size                = string   # VM size for node pool
  }))
}
