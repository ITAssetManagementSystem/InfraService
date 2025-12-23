module "rg" {
  source = "../../module/resource_group"
  rg     = var.rg
}

module "vnet" {
  depends_on = [module.rg]
  source     = "../../module/virtual_network"
  vnet       = var.vnet
}

module "subnet" {
  depends_on = [module.rg, module.vnet]
  source     = "../../module/subnet"
  subnet     = var.subnet
}

module "acr" {
  depends_on = [module.rg, module.vnet]
  source     = "../../module/azure_container_registry"
  acr        = var.acr
}

module "aks" {
  depends_on = [module.rg, module.vnet]
  source     = "../../module/azure_kubernetes"
  aks        = var.aks
}

module "aks_acr_role" {
  depends_on = [module.aks, module.acr]
  source     = "../../module/aks_acr_role_assignment"

  assignments = {
    for k, v in var.assignments : k => {
      acr_id            = module.acr.acr_ids[v.acr_key]
      kubelet_object_id = module.aks.aks_kubelet_ids[v.aks_key]
    }
  }
}

module "keyvault" {
  depends_on = [module.rg]
  source = "../../module/key_vault"
  kv     = var.kv
  sec    = var.sec
  
}

module "postgresql" {
  depends_on = [module.rg, module.vnet, module.subnet, module.keyvault]
  source = "../../module/postgre_sql"
  postgres_sql  = var.postgres_sql
  key_vault_ids = module.keyvault.key_vault_ids

}


module "postgredb" {
  depends_on          = [module.postgresql]
  source              = "../../module/postgre_db"
  postgres_db         = var.postgres_db
  postgres_server_ids = module.postgresql.postgres_server_ids
}
