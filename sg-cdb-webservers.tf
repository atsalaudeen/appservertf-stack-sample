resource "aws_security_group" "sg-test-webservers" {
  tags = {
    Name = "${var.PROJECT_NAME}-webservers-sg"
  }
  name = "${var.PROJECT_NAME}-webservers-sg"
  description = "Secutiry group for test webserver"
  vpc_id      = "${aws_vpc.main.id}"

# update this to your host ip or open vpc access
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["${var.SSH_CIDR_WEB_SERVER}"]
  }

# Add Application Load balancer access, should accept http only from load balancer only

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    security_groups = ["${aws_security_group.sg-alb-test-webservers.id}"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

