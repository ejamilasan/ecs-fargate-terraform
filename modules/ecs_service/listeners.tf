resource "aws_lb_listener" "lb_listener" {
  load_balancer_arn = data.aws_lb.aws_lb.arn
  port              = var.service_port
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb_target_group.arn
  }
}

resource "aws_lb_target_group" "lb_target_group" {
  name        = "${var.service_name}-tg"
  port        = var.service_port
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id

  health_check {
    path = "/health-check"
  }
}