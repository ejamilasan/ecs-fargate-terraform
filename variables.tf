# main
variable "region" { default = "us-east-1" }
variable "vpc_id" { default = "vpc-0203182bfa542a37b" }
variable "subnet_ids"  { default = ["subnet-0cf91aad132db4cb0", "subnet-074e1f95e078dbaf8"] }

# alb
variable "target_group_name" { default = "wordpressTargetGroup" }
variable "alb_name" { default = "wordpressALB" }
variable "service_port" { default = 80 }

# cloudwatch
variable "log_group_name" { default = "ecs/wordpressLogs" }

# iam
variable "task_role_name" { default = "ecsWordpressTaskRole" }

# ecs
variable "cluster_name" { default = "wordpressEcsCluster" }
variable "service_name" { default = "worpressEcsService" }
variable "ecs_image" { default = "wordpress:latest" }

# rds
variable "identifier" { default = "wordpress-mysql-rds" }
variable "rds_name" { default = "wordpressRDS" }
variable "username" { default = "edwin" }
variable "db_size" { default = "db.t2.small" }
variable "allocated_storage" { default = 5 }

# security groups
variable "rds_sg_name" { default = "rds-sg" }
variable "ecs_sg_name" { default = "ecs-sg" }