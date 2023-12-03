resource "aws_ecs_task_definition" "task_definition" {
  family                   = var.service_name
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 1024
  memory                   = 2048
  execution_role_arn       = aws_iam_role.ecs_task_role.arn

  container_definitions = jsonencode([
    {
      name             = var.service_name
      image            = "wordpress:latest"
      network_mode     = "awsvpc"
      cpu              = 1024
      memory           = 2048
      essential        = true
      logConfiguration = {
        logDriver = "awslogs"
        options   = {
          awslogs-group         = "${aws_cloudwatch_log_group.ecs_log_group.name}"
          awslogs-region        = var.region
          awslogs-stream-prefix = var.service_name
        }
      }
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
          protocol      = "tcp"
        }
      ]
      environment = [
        {
          name  = "WORDPRESS_DB_HOST"
          value = module.mysql_rds.db_instance_endpoint
        },
        {
          name  = "WORDPRESS_DB_USER"
          value = jsondecode(data.aws_secretsmanager_secret_version.db_secret.secret_string)["username"]
        },
        {
          name  = "WORDPRESS_DB_PASSWORD"
          value = jsondecode(data.aws_secretsmanager_secret_version.db_secret.secret_string)["password"]
        },
        {
          name  = "WORDPRESS_DB_NAME"
          value = "${var.service_name}RDS"
        }
      ]
    }
  ])

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "ARM64"
  }
}

resource "aws_ecs_service" "ecs_service" {
  name            = var.service_name
  launch_type     = "FARGATE"
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.task_definition.arn
  desired_count   = 1

  network_configuration {
    subnets          = aws_lb.lb.subnets
    security_groups  = [module.ecs_security_group.security_group_id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.lb_target_group.arn
    container_name   = var.service_name
    container_port   = 80
  }
}

resource "aws_ecs_cluster" "ecs_cluster" {
  name = var.cluster_name
}

data "aws_secretsmanager_secret_version" "db_secret" {
  secret_id = module.mysql_rds.db_instance_master_user_secret_arn
}