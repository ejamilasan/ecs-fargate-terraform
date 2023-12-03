resource "aws_lb" "lb" {
  name               = "${var.cluster_name}"
  internal           = false
  load_balancer_type = "application"
  subnets            = data.aws_subnets.default_vpc_subnets.ids
}
