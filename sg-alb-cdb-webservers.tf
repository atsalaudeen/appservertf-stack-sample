resource "aws_security_group" "sg-alb-test-webservers" {
  tags = {
    Name = "${var.PROJECT_NAME}-webservers-ALB"
  }
  name = "${var.PROJECT_NAME}-webservers-ALB"
  description = "Internet facing alb for common d"
  vpc_id      = "${aws_vpc.main.id}"

# for production, only https from specific port range only on https

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

