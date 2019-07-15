#Application load balancer for app server
resource "aws_lb" "back_end" {
  name               = "${var.PROJECT_NAME}-Back-End-ALB"
  internal           = true
  load_balancer_type = "application"
  security_groups    = ["${aws_security_group.sg-alb-test-appservers.id}"]
  subnets            = ["${aws_subnet.private_subnet_3.id}", "${aws_subnet.private_subnet_2.id}","${aws_subnet.private_subnet_1.id}"]

  # set to true for production
  enable_deletion_protection = false

  depends_on = ["aws_s3_bucket.test_app_alb_logs"]

  # enable for prod
  access_logs {
    bucket  = "${aws_s3_bucket.test_app_alb_logs.bucket}"
    prefix  = "appserver-test-alb-logs"
    enabled = false
  }

  tags = {
    Environment = "Test Env"
  }

}

# Add Target Group

resource "aws_lb_target_group" "back_end" {
  name     = "Target-Group-for-backend"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${aws_vpc.main.id}"
  health_check {
                path = "/"
                port = "80"
                protocol = "HTTP"
                healthy_threshold = 5
                unhealthy_threshold = 2
                interval = 30
                timeout = 5
                matcher = "200-308"
        }
}

# Adding HTTP listener for internal traffic

resource "aws_lb_listener" "appserver" {
  load_balancer_arn = "${aws_lb.back_end.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_lb_target_group.back_end.arn}"
    type             = "forward"
  }
}

output "Appserver_ALB_Endpoint" {
  value = "${aws_lb.back_end.dns_name}"
}

