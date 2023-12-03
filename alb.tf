resource "aws_lb" "lb" {
  name               = "${var.service_name}-alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = data.aws_subnets.default_vpc_subnets.ids
}

resource "aws_lb_listener" "lb_listener" {
  load_balancer_arn = aws_lb.lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb_target_group.arn
  }
}

resource "aws_lb_target_group" "lb_target_group" {
  name        = "${var.service_name}-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id

  health_check {
    path = "/health-check"
  }
}