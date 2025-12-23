output "client_certificate" {
  value = {
    for k, v in azurerm_kubernetes_cluster.aks :
    k => v.kube_config[0].client_certificate
  }
}

output "kube_config_raw" {
  value = {
    for k, v in azurerm_kubernetes_cluster.aks :
    k => v.kube_config_raw
  }
}
output "aks_identity_principal_ids" {
  value = {
    for k, v in azurerm_kubernetes_cluster.aks :
    k => v.identity[0].principal_id
  }
}

output "aks_kubelet_ids" {
  description = "AKS kubelet identity object IDs"
  value = {
    for k, v in azurerm_kubernetes_cluster.aks :
    k => v.kubelet_identity[0].object_id
  }
}

