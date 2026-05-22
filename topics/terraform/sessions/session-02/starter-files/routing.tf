locals {
  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "terraform"
  }
}

# TODO: aws_route_table — publiczna route table
# - vpc_id z zmiennej
# - route: cidr_block = "0.0.0.0/0", gateway_id = var.igw_id
# - tags: Name = "${var.project_name}-public-rt" + common_tags

# TODO: aws_route_table_association — przypisz route table do obu subnetów publicznych
# Użyj count lub for_each z var.public_subnet_ids
# - route_table_id = <route table powyżej>
# - subnet_id = element(var.public_subnet_ids, count.index) lub each.value
