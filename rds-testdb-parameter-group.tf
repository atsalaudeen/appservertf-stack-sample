resource "aws_db_parameter_group" "testdb-parameter-group" {
  name   = "testdb-charset-creators"
  description = "RDS parameters to attach to cdb"
  family = "mysql5.6"

  parameter {
    name  = "character_set_server"
    value = "utf8"
  }

  parameter {
    name  = "character_set_client"
    value = "utf8"
  }
}

