resource "aws_security_group" "sg-alb-test-appservers" {
  tags = {
    Name = "${var.PROJECT_NAME}-appservers-ALB-sg"
  }
  name = "${var.PROJECT_NAME}-appservers-ALB-sg"
  description = "App server alb sg"
  vpc_id      = "${aws_vpc.main.id}"

# only http only from webservers as this is internal facing ALB
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    security_groups = ["${aws_security_group.sg-test-webservers.id}"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

