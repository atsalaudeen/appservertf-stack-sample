resource "aws_db_instance" "testdb-rds-prod" {
  identifier = "${var.RDS_INSTANCE_ID}"
  name = "${var.RDS_NAME}"
  allocated_storage = "${var.RDS_ALLOCATED_STORAGE}"
  storage_type = "${var.rds_storage_type}"
  engine = "${var.RDS_ENGINE}"
  engine_version = "${var.RDS_ENGINE_VERSION}"
  instance_class = "${var.RDS_INSTANCE_CLASS}"
  backup_retention_period = "${var.RDS_BACKUP_RETENTION_PERIOD}"
  publicly_accessible = "${var.RDS_PUBLICLY_ACCESSIBLE}"
  username = "${var.RDS_USERNAME}"
  password = "${var.RDS_PASSWORD}"
  vpc_security_group_ids = ["${aws_security_group.sg-rds-test.id}"]
  db_subnet_group_name = "${aws_db_subnet_group.rds_subnet_group.name}"
  copy_tags_to_snapshot = "false"
  availability_zone = "${var.RDS_AVAILABILITY_ZONE}"
  multi_az = "false"
  #
  backup_window = "${var.RDS_BACKUP_WINDOW}"
  maintenance_window = "${var.RDS_MAINTENANCE_WINDOW}"

  storage_encrypted = "${var.RDS_STORAGE_ENCRYPTION}"

  # some random key, obtain real key on aws
  #kms_key_id = "${var.rds_kms_key_id}"

  # enable storage autoscaling
  max_allocated_storage   = "${var.rds_max_allocated_storage}"

  # set this to none default for production
  #parameter_group_name = "default.mysql5.6"
  parameter_group_name = "${aws_db_parameter_group.testdb-parameter-group.name}"

  # not for production
  #snapshot_identifier = "snapshotname01"
  skip_final_snapshot = true

  tags = {
      workload-type = "testprod"
  }
}

resource "aws_db_subnet_group" "rds_subnet_group" {
    name          = "${var.PROJECT_NAME}_rds_subnet_group"
    description   = "Allowed subnets for RDS cluster instances"
    subnet_ids    = [
      "${aws_subnet.private_subnet_1.id}",
      "${aws_subnet.private_subnet_2.id}",
      "${aws_subnet.private_subnet_3.id}"
    ]
}

output "testdb_rds_prod_endpoint" {
  value = "${aws_db_instance.testdb-rds-prod.endpoint}"
  description = "Mysql RDS endpoint"
}

