rg = {
  rg1 = {
    name     = "dev-rg"
    location = "East US"
  }
}

vnet = {
  vnet1 = {
    name                = "dev-vnet"
    resource_group_name = "dev-rg"
    location            = "East US"
    address_space       = ["10.0.0.0/16"]
  }
}

subnet = {
  subnet1 = {
    name                 = "backend-subnet"
    resource_group_name  = "dev-rg"
    virtual_network_name = "dev-vnet"
    address_prefixes     = ["10.0.1.0/24"]
  }

  subnet2 = {
    name                 = "db-subnet"
    resource_group_name  = "dev-rg"
    virtual_network_name = "dev-vnet"
    address_prefixes     = ["10.0.2.0/24"]
  }
}

acr = {
  acr1 = {
    name                = "devacr231225"
    resource_group_name = "dev-rg"
    location            = "East US"
    sku                 = "Standard"
    admin_enabled       = false
  }
}

aks = {
  aks1 = {
    name                = "dev-aks"
    location            = "East US"
    resource_group_name = "dev-rg"
    dns_prefix          = "devaks"
    size             = "Standard_DC2ds_v3"
  }
}

postgres_sql = {
  postgres1 = {
    name                = "dev-postgres231225"
    resource_group_name = "dev-rg"
    location            = "East US"
    version             = "14"

    admin_username = "pgadmin"
    secret_name    = "postgres-password"
    kv_key         = "kv1"

    sku_name   = "B_Standard_B1ms"
    storage_mb = 32768
  }
}


kv = {
  kv1 = {
    name                = "dev-kv231225"
    location            = "East US"
    resource_group_name = "dev-rg"
  }
}

sec = {
  sec1 = {
    name   = "postgres-password"
    value  = "Strong@123"
    kv_key = "kv1"
  }
}

postgres_db = {
  db1 = {
    db_name    = "dev-postgredb231225"
    server_key = "postgres1"
  }
}

assignments = {
  aks1 = {
    acr_key = "acr1"
    aks_key = "aks1"
  }
}

