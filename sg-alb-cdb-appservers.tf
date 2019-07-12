resource "aws_security_group" "sg-alb-test-appservers" {
  tags = {
    Name = "${var.PROJECT_NAME}-appservers-ALB-sg"
  }
  name = "${var.PROJECT_NAME}-appservers-ALB-sg"
  description = "App server alb sg"
  vpc_id      = "${aws_vpc.main.id}"

# only https for external but http to accept from the appservers on http
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    security_groups = ["${aws_security_group.sg-test-appservers.id}"]
  }

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

