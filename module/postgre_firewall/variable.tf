variable "firewall_rules" {
  description = "PostgreSQL firewall rules"
  type = map(object({
    name       = string
    server_key = string
    start_ip   = string
    end_ip     = string
  }))
}

variable "postgres_server_ids" {
  description = "Map of PostgreSQL server IDs"
  type        = map(string)
}
