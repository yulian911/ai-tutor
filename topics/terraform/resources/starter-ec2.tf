# Starter file — przykład: EC2 z IAM role i security group
# Technologia: Terraform >= 1.9, AWS Provider >= 5.50
# Poziom: junior+

# TODO: Pobierz aktualny AMI Amazon Linux 2023 za pomocą data source
# aws_ami — filtr po name "al2023-ami-*" i owner "amazon"

# TODO: Utwórz aws_security_group dla EC2
# - ingress: port 22 z twojego IP (/32)
# - ingress: port 80 z load balancer SG (użyj zmiennej alb_sg_id)
# - egress: all 0.0.0.0/0
# - tag Name

# TODO: Utwórz aws_iam_role dla EC2
# - assume_role_policy: ec2.amazonaws.com
# - tag Name

# TODO: Utwórz aws_iam_instance_profile
# - podłącz role

# TODO: Utwórz aws_instance
# - ami z data source (powyżej)
# - instance_type z zmiennej
# - subnet_id z zmiennej (prywatny subnet)
# - vpc_security_group_ids z SG powyżej
# - iam_instance_profile z instance_profile powyżej
# - user_data z base64encode(templatefile(...))
# - tags: Name, Project, Environment, ManagedBy = "terraform"

# Uwaga: nie hardcode AMI ID — zawsze używaj data source
