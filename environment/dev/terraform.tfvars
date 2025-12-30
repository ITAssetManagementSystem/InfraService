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
    name                = "devacr301225"
    resource_group_name = "dev-rg"
    location            = "East US"
    sku                 = "Standard"
    admin_enabled       = false
  }
}

aks = {
  aks1 = {
    name                = "dev-aks"
    location            = "Canada Central"
    resource_group_name = "dev-rg"
    dns_prefix          = "devaks"
    size                = "Standard_DC2ds_v3"
  }
}

kv = {
  kv1 = {
    name                = "dev-kv301225"
    location            = "East US"
    resource_group_name = "dev-rg"
  }
}

# if we use RBAC for key vault no need the secrets here because they will be created directly in the key vault
sec = {
  sec1 = {
    name   = "postgres-password"
    value  = "Strong@123"
    kv_key = "kv1"
  }
}


#  AKS ↔ ACR role assignment
assignments = {
  aks1 = {
    acr_key = "acr1"
    aks_key = "aks1"
  }
}

#  KEY VAULT RBAC 
keyvault_assignments = {
  terraform = {
    principal_type = "terraform"
    kv_key         = "kv1"
  }

  aks = {
    principal_type = "aks"
    kv_key         = "kv1"
  }
}

postgres_sql = {
  postgres1 = {
    name                = "dev-postgres301225"
    resource_group_name = "dev-rg"
    location            = "centralindia"
    version             = "14"
    admin_username      = "pgadmin"
    secret_name         = "postgres-password"
    kv_key              = "kv1"
    sku_name            = "B_Standard_B1ms"
    storage_mb          = 32768
  }
}

postgres_db = {
  db1 = {
    db_name    = "assetdb"
    server_key = "postgres1"
  }
  db2 = {
    db_name    = "employeedb"
    server_key = "postgres1"
  }
  db3 = {
    db_name    = "assignmentdb"
    server_key = "postgres1"
  }
}

postgres_firewall_rules = {

  #  Allow Azure Services
  allow_azure = {
    name       = "Allow-Azure-Services"
    server_key = "postgres1"
    start_ip   = "0.0.0.0"
    end_ip     = "0.0.0.0"
  }

  # 🔥 Allow Office / Client IP
  my_laptop = {
    name       = "My-Laptop-IP"
    server_key = "postgres1"
    start_ip   = "49.36.120.15"
    end_ip     = "49.36.120.15"
  }
}
