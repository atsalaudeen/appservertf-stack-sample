#Application load balancer for app server
resource "aws_lb" "front_end" {
  name               = "${var.PROJECT_NAME}-Front-End-ALB"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${aws_security_group.sg-alb-test-webservers.id}"]
  subnets            = ["${aws_subnet.public_subnet_3.id}", "${aws_subnet.public_subnet_2.id}","${aws_subnet.public_subnet_1.id}"]
  # set to true for production
  enable_deletion_protection = false

  depends_on = ["aws_s3_bucket.test_web_alb_logs"]

  # enable for prod
  access_logs {
    bucket  = "${aws_s3_bucket.test_web_alb_logs.bucket}"
    prefix  = "webserver-test-alb-logs"
    enabled = false
  }

  tags = {
    Environment = "Test Env"
  }
}

# Add Target Group

resource "aws_lb_target_group" "front_end" {
  name     = "Target-Group-for-frontend"
  port     = 443
  protocol = "HTTP"
  vpc_id   = "${aws_vpc.main.id}"
  health_check {
                path = "/"
                port = "80"
                protocol = "HTTP"
                healthy_threshold = 2
                unhealthy_threshold = 10
                interval = 5
                timeout = 10
                matcher = "200-308"
        }
}

# Adding HTTP listener if not using ssl

# resource "aws_lb_listener" "webserver" {
#  load_balancer_arn = "${aws_lb.front_end.arn}"
  #port              = "80"
  #protocol          = "HTTP"
#
#  default_action {
#    target_group_arn = "${aws_lb_target_group.front_end.arn}"
#    type             = "forward"
#  }
#}

# for production only https, example using ACM generated certificates

#resource "aws_lb_listener" "front_end" {
#  load_balancer_arn = "${aws_lb.front_end.arn}"
#  port              = "443"
#  protocol          = "HTTPS"
#  ssl_policy        = "ELBSecurityPolicy-2016-08"
#  certificate_arn   = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"
#
#  default_action {
#    type             = "forward"
#    target_group_arn = "${aws_lb_target_group.front_end.arn}"
#  }


# To Use self signed certifiates in certificate directory

resource "aws_iam_server_certificate" "url_myCompany_TestWebsite1" {
  name      = "myCompanyTestWeb_site1.com"
  certificate_body = "${file("certificates/ca-test-public.crt")}"
  private_key      = "${file("certificates/ca-test-private-key.pem")}"
}

# Enable certificate in lister
resource "aws_lb_listener" "front_end" {
  load_balancer_arn = "${aws_lb.front_end.arn}"
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = "${aws_iam_server_certificate.url_myCompany_TestWebsite1.arn}"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.front_end.arn}"
  }
}

output "WebServer_Load_Balancer_Endpoint" {
  value = "${aws_lb.front_end.dns_name}"
}

