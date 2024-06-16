resource "aws_alb" "hello_world_alb" {
  name               = "hello-world-alb-inbar" 
  load_balancer_type = "application"
  subnets = module.vpc.public_subnets
  #security group
  security_groups = ["${aws_security_group.alb-sg.id}"]
}


resource "aws_lb_target_group" "hello_world_tg" {
  name        = "hello-world-tg-inbar"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = module.vpc.vpc_id # VPC
  health_check {
    interval            = 30
    path                = "/"
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
    matcher             = "200-299"
  }
}

resource "aws_lb_listener" "hello_world_listener" {
  load_balancer_arn = "${aws_alb.hello_world_alb.arn}" # load balancer
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.hello_world_tg.arn}" # tagrte group
  }
}
