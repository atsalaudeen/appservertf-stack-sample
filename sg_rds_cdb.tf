resource "aws_security_group" "sg-rds-test" {
  tags = {
    Name = "${var.PROJECT_NAME}-rds-sg"
  }
  name = "${var.PROJECT_NAME}-rds-sg"
  description = "Security group for RDS"
  vpc_id      = "${aws_vpc.main.id}"

  ingress {
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    cidr_blocks = ["${var.VPC_CIDR_BLOCK}"]
  }
# mysql access to webservers
  ingress {
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    security_groups = ["${aws_security_group.sg-test-appservers.id}"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

