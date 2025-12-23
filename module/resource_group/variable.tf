variable "rg" {
  description = "Resource Group configuration map"
  type = map(object({
    name     = string
    location = string
  }))
}
