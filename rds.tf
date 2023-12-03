module "mysql_rds" {
  source = "terraform-aws-modules/rds/aws"

  identifier           = var.identifier
  engine               = "mysql"
  engine_version       = "8.0.35"
  major_engine_version = "8.0"
  family               = "mysql8.0"
  instance_class       = var.db_size
  allocated_storage    = var.allocated_storage

  iam_database_authentication_enabled = false

  db_name                     = var.rds_name
  username                    = var.username
  manage_master_user_password = true
  port                        = 3306
  db_subnet_group_name        = aws_db_subnet_group.rds_subnet_group.arn
  vpc_security_group_ids      = [module.rds_security_group.security_group_id]

  maintenance_window      = "Sun:07:00-Sun:09:00" # 1am-3am CDT
  backup_window           = "09:00-12:00"         # 3am-5am CDT
  backup_retention_period = 7

  create_cloudwatch_log_group = false

  monitoring_interval    = "30"
  monitoring_role_arn    = aws_iam_role.rds_monitoring_role.arn
  create_monitoring_role = false

  deletion_protection = false
}

resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "default-subnet-group"
  subnet_ids = var.subnet_ids
}