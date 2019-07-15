resource "aws_autoscaling_notification" "asg_test_webserver_notifications" {
  group_names = [
    "${aws_autoscaling_group.test_webserver.name}",
  ]

  notifications = [
    "autoscaling:EC2_INSTANCE_LAUNCH_ERROR",
    "autoscaling:EC2_INSTANCE_TERMINATE_ERROR",
  ]

  topic_arn = "${aws_sns_topic.techsupport-emergency.arn}"
}

#resource "aws_sns_topic" "techsupport-emergency" {
#  name = "techsupport-emergency-awsconfig"

#  # arn is an exported attribute
#}

resource "aws_autoscaling_group" "test_webserver" {
  name                      = "WebServer-asg"
  max_size                  = 2
  min_size                  = 1
  health_check_grace_period = 300
  health_check_type         = "EC2"
  desired_capacity          = 1
  force_delete              = true
  launch_configuration      = "${aws_launch_configuration.asg_temp_for_webserver.name}"
  vpc_zone_identifier       = ["${aws_subnet.private_subnet_1.id}", "${aws_subnet.private_subnet_2.id}", "${aws_subnet.private_subnet_3.id}"]
  target_group_arns         = ["${aws_lb_target_group.front_end.arn}"]

  tags = [
      {
        key                 = "Backup"
        value               = "false"
        propagate_at_launch = true
      },
      {
        key                 = "Environment"
        value               = "DevTest"
        propagate_at_launch = true
      },
      {
        key                 = "InstanceReplacement"
        value               = "false"
        propagate_at_launch = false
      },
      {
        key                 = "Name"
        value               = "WebserverASG"
        propagate_at_launch = true
      },
    ]
}

