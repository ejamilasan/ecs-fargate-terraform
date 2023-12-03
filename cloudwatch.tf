resource "aws_cloudwatch_log_group" "ecs_log_group" {
  name = var.log_group_name
}