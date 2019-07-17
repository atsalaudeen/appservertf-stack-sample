# Example with CPUUtilization > 60% for 3 datapoints within the last 3 minutes
# Scale UP : autoscaling action on Alarm
# App server
# Add one instance and wait 60 seconds if in alarm state
resource "aws_autoscaling_policy" "highcpu-appserver-policy" {
  name                   = "scaleuphighcpu-test-appserver-policy"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 60
  autoscaling_group_name = "${aws_autoscaling_group.test_appserver.name}"
}

resource "aws_cloudwatch_metric_alarm" "highcpu-appserver-alarm" {
  alarm_name          = "scaleuphighcpu-appserver-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "3"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "180"
  statistic           = "Average"
  threshold           = "60"

  dimensions = {
    AutoScalingGroupName = "${aws_autoscaling_group.test_appserver.name}"
  }

  alarm_description   = "This metric monitors Appserver CPU Utilization exceeding 60%"
  alarm_actions     = ["${aws_autoscaling_policy.highcpu-appserver-policy.arn}"]
}

#
# Web server
# Add one instance and wait 60 seconds if in alarm state
resource "aws_autoscaling_policy" "highcpu-webserver-policy" {
  name                   = "scaleuphighcpu-test-webserver-policy"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 60
  autoscaling_group_name = "${aws_autoscaling_group.test_webserver.name}"
}

resource "aws_cloudwatch_metric_alarm" "highcpu-webserver-alarm" {
  alarm_name          = "scaleuphighcpu-webserver-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "3"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "180"
  statistic           = "Average"
  threshold           = "60"

  dimensions = {
    AutoScalingGroupName = "${aws_autoscaling_group.test_webserver.name}"
  }

  alarm_description   = "This metric monitors Webserver CPU Utilization exceeding 60%"
  alarm_actions     = ["${aws_autoscaling_policy.highcpu-webserver-policy.arn}"]
}

########## SCALE DOWN
# Example with CPUUtilization < 30% for 3 datapoints within the last 15 minutes
# Scale DOWN : autoscaling action on Alarm
# App server
# Remove one instance and wait 60 seconds if in alarm state
resource "aws_autoscaling_policy" "lowcpu-appserver-policy" {
  name                   = "scaleuplowcpu-test-appserver-policy"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 60
  autoscaling_group_name = "${aws_autoscaling_group.test_appserver.name}"
}

resource "aws_cloudwatch_metric_alarm" "lowcpu-appserver-alarm" {
  alarm_name          = "scaleuplowcpu-appserver-alarm"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "3"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "900"
  statistic           = "Average"
  threshold           = "30"

  dimensions = {
    AutoScalingGroupName = "${aws_autoscaling_group.test_appserver.name}"
  }

  alarm_description   = "This metric monitors App server CPU Utilization dropping below 30%"
  alarm_actions     = ["${aws_autoscaling_policy.lowcpu-appserver-policy.arn}"]
}

#
# Web server
# Remove one instance and wait 60 seconds if in alarm state
resource "aws_autoscaling_policy" "lowcpu-webserver-policy" {
  name                   = "scaleuplowcpu-test-webserver-policy"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 60
  autoscaling_group_name = "${aws_autoscaling_group.test_webserver.name}"
}

resource "aws_cloudwatch_metric_alarm" "lowcpu-webserver-alarm" {
  alarm_name          = "scaleuplowcpu-webserver-alarm"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "3"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "900"
  statistic           = "Average"
  threshold           = "30"

  dimensions = {
    AutoScalingGroupName = "${aws_autoscaling_group.test_webserver.name}"
  }

  alarm_description   = "This metric monitors Web server CPU Utilization dropping below 30%"
  alarm_actions     = ["${aws_autoscaling_policy.lowcpu-webserver-policy.arn}"]
}

