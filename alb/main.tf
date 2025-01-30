resource "aws_alb" "app_lb" {
  name               = "web-alb"
  internal           = false # Or true if internal
  load_balancer_type = "application"
  subnets            = var.subnet_ids
  security_groups    = [var.alb_security_group_id]
}

resource "aws_alb_target_group" "app_tg" {
  name     = "web-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path               = "/" # Application health check path
    protocol           = "HTTP"
    matcher            = "200"
    interval           = 30
    timeout            = 5
    healthy_threshold  = 2
    unhealthy_threshold = 2
  }
}

resource "aws_alb_listener" "http" {
  load_balancer_arn = aws_alb.app_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.app_tg.arn
  }
}
