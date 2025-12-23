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

module "postgresql" {
  depends_on   = [module.rg, module.vnet, module.subnet]
  source       = "../../module/postgre_sql"
  postgres_sql = var.postgres_sql
}


module "postgredb" {
  depends_on          = [module.rg, module.postgresql]
  source              = "../../module/postgre_db"
  postgres_db         = var.postgres_db
  postgres_server_ids = module.postgresql.postgres_server_ids
}

