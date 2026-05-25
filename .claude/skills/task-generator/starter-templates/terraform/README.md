# Starter Template — Terraform

## main.tf

```hcl
# TODO: zdefiniuj provider AWS (region)
terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# TODO: dodaj provider "aws" ze zmienną region
provider "aws" {
  region = var.aws_region
}

# TODO: zdefiniuj resource główny (np. security group, instance, bucket)
# Przykład:
# resource "aws_security_group" "example" {
#   name_prefix = "example-"
#   vpc_id      = var.vpc_id
#
#   ingress {
#     # TODO: zdefiniuj reguły ingress
#   }
#
#   egress {
#     # TODO: zdefiniuj reguły egress
#   }
#
#   tags = {
#     Name        = "example-sg"
#     Environment = var.environment
#   }
# }
```

## variables.tf

```hcl
# TODO: zdefiniuj zmienne dla konfiguracji
# Przykład:

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be dev, staging, or prod."
  }
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
  # TODO: dodaj sensowny default lub ustaw required = true
}

# TODO: dodaj więcej zmiennych zgodnie z wymaganiami taska
```

## outputs.tf

```hcl
# TODO: wyeksportuj wartości dla dalszego użytku
# Przykład:

output "resource_id" {
  description = "ID of the created resource"
  value       = aws_security_group.example.id
}

output "resource_arn" {
  description = "ARN of the created resource"
  value       = aws_security_group.example.arn
}

# TODO: dodaj więcej outputs zgodnie z wymaganiami taska
```

## terraform.tfvars

```hcl
# TODO: uzupełnij wartości zmiennych dla środowiska dev

aws_region = "us-east-1"
environment = "dev"
vpc_id     = "vpc-0123456789abcdef0"

# TODO: dodaj więcej zmiennych z variables.tf
```
