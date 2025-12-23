rg = {
  rg1 = {
    name     = "dev-rg"
    location = "centralindia"
  }
}

vnet = {
  vnet1 = {
    name                = "dev-vnet"
    resource_group_name = "dev-rg"
    location            = "centralindia"
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
    location            = "centralindia"
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
    size                = "Standard_DC2ds_v3"
  }
}

postgres_sql = {
  postgres1 = {
    name                = "dev-postgres231225"
    resource_group_name = "dev-rg"
    location            = "centralindia"
    version             = "14"

    admin_username = "pgadmin"
    admin_password = "pgadmin@123"

    #zone                = "1"
    storage_mb   = 32768
    storage_tier = "P4"
    sku_name     = "B_Standard_B1ms"
  }
}

postgres_db = {
  postgres_db1 = {
    db_name    = "dev-postgredb231225"
    server_key = "postgres1" # refers to postgres["dev"]
  }
}

