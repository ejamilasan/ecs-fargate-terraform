module "ecs_security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.1.0"

  name        = "${var.service_name}-ecs-sg"
  description = "security group for ECS"
  vpc_id      = var.vpc_id

  ingress_cidr_blocks = var.whitelisted_ips
  ingress_rules       = ["all-tcp"]
  egress_rules        = ["all-all"]
}

module "rds_security_group" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "${var.service_name}-rds-sg"
  description = "security group for RDS"
  vpc_id      = var.vpc_id

  ingress_cidr_blocks = [data.aws_vpc.default_vpc.cidr_block]
  ingress_rules       = ["mysql-tcp"]
  egress_rules        = ["all-all"]
}