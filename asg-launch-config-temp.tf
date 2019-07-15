resource "aws_launch_configuration" "asg_temp_for_webserver" {
  name   = "AutoScaleGrp-webserver-1"
  # to use ubuntu ami
  #image_id      = "${data.aws_ami.ubuntu.id}"
  # use amz2 image
  image_id      = "ami-0b898040803850657"
  instance_type = "${var.WEB_SERVER_INSTANCE_TYPE}"
  user_data = "${file("${var.USER_DATA_FOR_WEBSERVER}")}"
  security_groups = ["${aws_security_group.sg-test-webservers.id}"]
  key_name = "${var.PEM_FILE_WEBSERVERS}"
  root_block_device {
    volume_type = "gp2"
    volume_size = "30"
    delete_on_termination = true
  }
}

resource "aws_launch_configuration" "asg_temp_for_appserver" {
  name   = "AutoScaleGrp-appserver-1"
  # to use ubuntu ami
  #image_id      = "${data.aws_ami.ubuntu.id}"
  # use amz2 image
  image_id      = "ami-0b898040803850657"
  instance_type = "${var.APP_SERVER_INSTANCE_TYPE}"
  user_data = "${file("${var.USER_DATA_FOR_APPSERVER}")}"
  security_groups = ["${aws_security_group.sg-test-appservers.id}"]
  key_name = "${var.PEM_FILE_APPSERVERS}"

  root_block_device {
    volume_type = "gp2"
    volume_size = "30"
    delete_on_termination = true
  }
}

# You can create the pem key here if not already created on aws.
#resource "aws_key_pair" "deployerkey" {
#    key_name = "deployer_key"
#    public_key = "ssh-rsa AAAAABkc2EAAAADAQABAAABAQD3F6tyPEFEzV0LX3X8BsXdMsQz1a;klyaer"
#}

# OR
#resource "aws_key_pair" "deployerkey" {
#    key_name = "deployer_key"
#    public_key = "${file("~/.ssh/testkey.pub")}"
#}


# Ubuntu ami
#data "aws_ami" "ubuntu" {
#  most_recent = "true"
# owners = ["099720109477"]
#  filter
#  {
#  name = "name"
#  values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
#  }
# filter
# {
#  name = "virtualization-type"
#  values = ["hvm"]
# }
#}

#output "aws_ami" "ubuntu"
#{
#  value = "${data.aws_ami.ubuntu.id}"
#}

