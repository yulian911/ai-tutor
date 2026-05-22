# Zmienne przekazywane z outputów sesji 01

variable "vpc_id" {
  type        = string
  description = "TODO: dodaj opis"
}

variable "public_subnet_ids" {
  type        = list(string)
  description = "TODO: dodaj opis"
}

variable "igw_id" {
  type        = string
  description = "TODO: dodaj opis"
}

variable "admin_cidr" {
  type        = string
  description = "TODO: CIDR skąd dozwolony jest SSH do EC2 (np. twoje IP /32)"
  # Przykład: "1.2.3.4/32"
}

variable "project_name" {
  type        = string
  description = "TODO"
  default     = "inventory-api"
}

variable "environment" {
  type        = string
  description = "TODO"
  default     = "dev"
}
