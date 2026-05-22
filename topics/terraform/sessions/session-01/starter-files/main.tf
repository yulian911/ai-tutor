terraform {
  required_version = "TODO"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "TODO"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# Lokalne wartości pomocnicze
locals {
  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "terraform"
  }
}

# TODO: aws_vpc
# - cidr_block z zmiennej
# - enable_dns_support = true
# - enable_dns_hostnames = true
# - tags: merge(local.common_tags, { Name = "${var.project_name}-vpc" })

# TODO: aws_subnet — publiczne (2 sztuki, użyj count lub for_each)
# - vpc_id
# - cidr_block z listy var.public_subnet_cidrs
# - availability_zone — eu-west-1a dla [0], eu-west-1b dla [1]
# - map_public_ip_on_launch = true
# - tags: Name, Type = "public" + common_tags

# TODO: aws_subnet — prywatne (2 sztuki, użyj count lub for_each)
# - vpc_id
# - cidr_block z listy var.private_subnet_cidrs
# - availability_zone — eu-west-1a dla [0], eu-west-1b dla [1]
# - map_public_ip_on_launch = false
# - tags: Name, Type = "private" + common_tags

# TODO: aws_internet_gateway
# - vpc_id z referencji do aws_vpc
# - tags: Name + common_tags
