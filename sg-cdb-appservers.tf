resource "aws_security_group" "sg-test-appservers" {
  tags = {
    Name = "${var.PROJECT_NAME}-appservers-sg"
  }
  name = "${var.PROJECT_NAME}-appservers-sg"
  description = "Secutiry group for test appserver"
  vpc_id      = "${aws_vpc.main.id}"

# Allow ssh access 
  ingress {
     from_port = 22
     to_port = 22
     protocol = "tcp"
     cidr_blocks = ["${var.SSH_CIDR_APP_SERVER}"]
   }
  # Add Application Load balancer access, to the public facing alb security group
  ingress {
      from_port = 80
      to_port = 80
      protocol = "tcp"
      security_groups = ["${aws_security_group.sg-alb-test-appservers.id}"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

