variable "aws_region" {
  type        = string
  description = "TODO: dodaj opis"
  default     = "TODO"
}

variable "vpc_cidr" {
  type        = string
  description = "TODO: dodaj opis"
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "TODO: dodaj opis — lista CIDR dla subnetów publicznych"
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "TODO: dodaj opis — lista CIDR dla subnetów prywatnych"
}

variable "project_name" {
  type        = string
  description = "TODO: dodaj opis"
}

variable "environment" {
  type        = string
  description = "TODO: dodaj opis"
  # TODO: dodaj validation — allowed values: dev, staging, prod
}
