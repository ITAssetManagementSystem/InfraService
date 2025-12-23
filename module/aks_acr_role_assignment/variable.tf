variable "assignments" {
  type = map(object({
    acr_id            = string
    kubelet_object_id = string
  }))
}
