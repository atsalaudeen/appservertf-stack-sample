resource "aws_security_group" "sg_testdb-appservers" {
  tags = {
    Name = "sg_${var.PROJECT_NAME}-testdb-appservers"
  }
  name = "sg_${var.PROJECT_NAME}-testdb-appservers"
  description = "Secutiry group for testdb appserver"
  vpc_id      = "${aws_vpc.main.id}"

  # update this will all sg inbound rules allowed on port 80
  ## create the following associated security_groups

  #ingress {
  #  from_port = 80
  #  to_port = 80
  #  protocol = "tcp"
  #  security_groups = ["${aws_security_group.sg_alb-testdb-alg.id}"]
  #}
  # review 
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["${var.VPC_CIDR_BLOCK}"]
  }

 # update this will all sg inbound rules allowed on port 80
## create the following associated security_groups
# add open vpn access

#ingress {
#  from_port = 80
#  to_port = 80
#  protocol = "tcp"
#  security_groups = ["${aws_security_group.sg_alb-testdb-alg.id}"]
#}

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

