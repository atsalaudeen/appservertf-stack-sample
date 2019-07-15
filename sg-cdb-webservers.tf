resource "aws_security_group" "sg-test-webservers" {
  tags = {
    Name = "${var.PROJECT_NAME}-webservers-sg"
  }
  name = "${var.PROJECT_NAME}-webservers-sg"
  description = "Secutiry group for test appserver"
  vpc_id      = "${aws_vpc.main.id}"

# update this to your host ip or open vpc access
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["${var.SSH_CIDR_WEB_SERVER}"]
  }

  # update this will all sg inbound rules allowed on port 80
  ## create the following associated security_groups

# Add Application Load balancer access, should accept http only from load balancer

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    security_groups = ["${aws_security_group.sg-alb-test-appservers.id}"]
  }

  # Add Application Load balancer access, all external traffic on https or to specific subnet e.g cloud front IP addresses

  ingress {
      from_port = 443
      to_port = 443
      protocol = "tcp"
      security_groups = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

