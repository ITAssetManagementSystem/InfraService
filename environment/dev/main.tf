# Phase-1: Key Vault + RBAC
# Phase-2: azurerm_key_vault_secret resource
# Phase-3: PostgreSQL
data "azurerm_client_config" "current" {}

############################
# Resource Group
############################
module "rg" {
  source = "../../module/resource_group"
  rg     = var.rg
}

############################
# Virtual Network
############################
module "vnet" {
  depends_on = [module.rg]
  source     = "../../module/virtual_network"
  vnet       = var.vnet
}

############################
# Subnet
############################
module "subnet" {
  depends_on = [module.rg, module.vnet]
  source     = "../../module/subnet"
  subnet     = var.subnet
}

############################
# Azure Container Registry
############################
module "acr" {
  depends_on = [module.rg, module.vnet]
  source     = "../../module/azure_container_registry"
  acr        = var.acr
}

############################
# AKS Cluster
############################
module "aks" {
  depends_on = [module.rg, module.vnet]
  source     = "../../module/azure_kubernetes"
  aks        = var.aks
}

############################
# AKS ↔ ACR Role Assignment
############################
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

# resource "time_sleep" "wait_for_kv_rbac" {
#   depends_on = [
#     module.keyvault_rbac
#   ]

#   create_duration = "120s"
# }


############################
# Key Vault + Secret + RBAC
############################
module "keyvault" {
  depends_on = [
    module.rg,module.aks
    # time_sleep.wait_for_kv_rbac
  ]

  source = "../../module/key_vault"
  kv  = var.kv
  sec = var.sec

}

module "keyvault_rbac" {
  depends_on = [
    module.keyvault,
    module.aks
  ]

  source = "../../module/keyvault_role_assignment"
   # 🔥 FIXED: correct variable name = assignments
  keyvault_assignments = {
    for k, v in var.keyvault_assignments : k => {
      scope = module.keyvault.key_vault_ids[v.kv_key]
      principal_id = (
        v.principal_type == "terraform"
        ? data.azurerm_client_config.current.object_id
        : module.aks.aks_kubelet_ids["aks1"]
      )

      role_name = (
        v.principal_type == "terraform"
        ? "Key Vault Secrets Officer"
        : "Key Vault Secrets User"
      )
    kv_key = v.kv_key
    }
  }
  }



############################
# PostgreSQL Server
############################
module "postgresql" {
  depends_on = [
    module.rg,
    module.vnet,
    module.subnet,
    module.keyvault,
    module.keyvault_rbac 
  ]

  source = "../../module/postgre_sql"

  postgres_sql  = var.postgres_sql
  key_vault_ids = module.keyvault.key_vault_ids
}

############################
# PostgreSQL Database
############################

module "postgredb" {
  depends_on          = [module.postgresql]
  source              = "../../module/postgre_db"
  postgres_db         = var.postgres_db
  postgres_server_ids = module.postgresql.postgres_server_ids
}

############################
# PostgreSQL Firewall Rules
############################
module "postgres_firewall" {
  depends_on = [
    module.postgresql
  ]

  source = "../../module/postgre_firewall"

  firewall_rules      = var.postgres_firewall_rules
  postgres_server_ids = module.postgresql.postgres_server_ids
}
