variable "region" {
  type = string
  description = "Aws region to deploy resource"
}

variable "rds_username" {
  type = string
  description = "Master username for rds"
}

variable "rds_password" {
  type = string
  description = "Master password for rds"
}
