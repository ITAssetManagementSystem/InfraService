variable "postgres_db" {
  description = "PostgreSQL databases"
  type = map(object({
    db_name    = string
    server_key = string
  }))
}


variable "postgres_server_ids" {
  type = map(string)
}
