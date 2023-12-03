module "mysql_rds" {
  source = "terraform-aws-modules/rds/aws"

  identifier           = "${var.service_name}-rds-identifier"
  engine               = "mysql"
  engine_version       = "8.0.35"
  major_engine_version = "8.0"
  family               = "mysql8.0"
  instance_class       = "db.t2.small"
  allocated_storage    = 5

  iam_database_authentication_enabled = false

  db_name                     = "${var.service_name}RDS"
  username                    = "edwin"
  manage_master_user_password = true
  port                        = 3306
  db_subnet_group_name        = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids      = [module.rds_security_group.security_group_id]

  create_cloudwatch_log_group = false

  monitoring_interval    = "30"
  monitoring_role_arn    = aws_iam_role.rds_monitoring_role.arn
  create_monitoring_role = false

  deletion_protection = false
}

resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "${var.service_name}-subnet-group"
  subnet_ids = data.aws_subnets.default_vpc_subnets.ids
}