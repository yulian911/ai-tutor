# TODO: Security Group — ALB
# aws_security_group
# - name = "${var.project_name}-alb-sg"
# - vpc_id = var.vpc_id
# - description = "Security group for ALB"
# - tags: Name + common_tags
#
# Ingress rules:
# - port 80  (HTTP)  protocol tcp  cidr_blocks = ["0.0.0.0/0"]
# - port 443 (HTTPS) protocol tcp  cidr_blocks = ["0.0.0.0/0"]
#
# Egress rules:
# - all traffic  protocol -1  cidr_blocks = ["0.0.0.0/0"]

# TODO: Security Group — EC2
# aws_security_group
# - name = "${var.project_name}-ec2-sg"
# - vpc_id = var.vpc_id
# - description = "Security group for EC2 app servers"
# - tags: Name + common_tags
#
# Ingress rules:
# - port 8080  protocol tcp  source_security_group_id = <ALB SG id>
#   (NIE cidr_blocks — tylko z ALB!)
# - port 22    protocol tcp  cidr_blocks = [var.admin_cidr]
#   (NIE 0.0.0.0/0 — to błąd bezpieczeństwa!)
#
# Egress rules:
# - all traffic  protocol -1  cidr_blocks = ["0.0.0.0/0"]
