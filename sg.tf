module "ecs_security_group" {
  source = "terraform-aws-modules/security-group/aws"

  name        = var.ecs_sg_name
  description = "security group for ECS"
  vpc_id      = var.vpc_id

  ingress_cidr_blocks = ["136.34.178.105/32"]
  ingress_rules       = ["all-tcp"]
  egress_rules        = ["all-all"]
}

module "rds_security_group" {
  source = "terraform-aws-modules/security-group/aws"

  name        = var.rds_sg_name
  description = "security group for RDS"
  vpc_id      = var.vpc_id

  ingress_cidr_blocks = ["10.0.0.0/8"]
  ingress_rules       = ["mysql-tcp"]
  egress_rules        = ["all-all"]
}