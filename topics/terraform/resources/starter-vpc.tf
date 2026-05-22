# Starter file — przykład: VPC z subnetami
# Technologia: Terraform >= 1.9, AWS Provider >= 5.50
# Poziom: junior

terraform {
  required_version = ">= 1.9"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.50"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# TODO: Utwórz zasób aws_vpc
# - cidr_block z zmiennej
# - enable_dns_support = true
# - enable_dns_hostnames = true
# - tag Name z prefiksem projektu

# TODO: Utwórz 2 subnety publiczne (w różnych AZ)
# - cidr_block z list(string) variable
# - map_public_ip_on_launch = true
# - tagi: Name, Type = "public"

# TODO: Utwórz 2 subnety prywatne (w różnych AZ)
# - cidr_block z list(string) variable
# - map_public_ip_on_launch = false
# - tagi: Name, Type = "private"

# TODO: Utwórz Internet Gateway
# - przypisz do VPC
# - tag Name
