# NOTE: RUN ONLY ON TEST ENVIRONMENT. NOT SUITABLE FOR PRODUCTION ENVIRONMENT
# Project wide variable
variable "PROJECT_NAME" {
  description = "Project aws account is running on."
  default     = "sta21-test-env"
}
# Varibles for the Providers
#
# variable "AWS_ACCESS_KEY" {}
# variable "AWS_SECRET_KEY" {}
variable "AWS_REGION" {
  description = "The AWS Region to run in."
  default     = "us-east-1"
}

# RDS Mysql Commondb variables

variable "RDS_NAME" {
    description = "The database name"
    default = "testdb"
}

variable "RDS_INSTANCE_ID" {
    description = "The RDS instance identifier"
    default = "test-env-db"
}

#variable "RDS_AVAILABILITY_ZONE" {
#    description = "The availability zone to place the instance into."
#    default = "us-east-1b"
#}

# Incease for production env
variable "RDS_INSTANCE_CLASS" {
  description = "RDS instance class"
  #default     = "db.t2.medium"
  #FOR Free demo environment setup use
  default     = "db.t2.micro"
}
variable "RDS_ENGINE" {
  description = "Database engine"
  default     = "mysql"
}
variable "RDS_ENGINE_VERSION" {
  description = "Running mysql engine version. If left blank, latest engine will be used."
  default     = "5.6.41"
}

# Incease for production env
variable "RDS_ALLOCATED_STORAGE" {
  description = "Storage size in gb"
  default     = "20"
}

variable "RDS_MAX_ALLOCATED_STORAGE" {
  description = "Enable storage auto-scaling with this. Size in gb"
  default     = "100"
}

# Incease for production env
variable "RDS_BACKUP_RETENTION_PERIOD" {
  description = "How many days to retain backups."
  default     = "7"
}

variable "RDS_BACKUP_WINDOW" {
    description = "The daily time range (in UTC) during which automated backups are created, if enabled."
    default = "09:00-10:00"
}

variable "RDS_MAINTENANCE_WINDOW" {
    description = "The period to carry out maintenance"
    default = "Sat:11:00-Sat:12:00"
}

variable "RDS_DELETION_PROTECTION" {
    description = "If the DB instance should have deletion protection enabled. The database can't be deleted when this value is set to true"
    default = "false"
}

variable "RDS_PUBLICLY_ACCESSIBLE" {
  description = "If true, the database can be connected via the internet."
  default     = "true"
}

## Create alternative method of authentication rather than hardcoding credentials.
variable "RDS_USERNAME" {
  description = "Username for the master DB user."
  default     = "testdbadmin"
}

variable "RDS_PASSWORD" {
  description = "Password for the master DB user."
  default     = "justrandompass"
}

# change for production
variable "RDS_STORAGE_ENCRYPTION" {
    description = "Specifies whether the DB instance is encrypted"
    default = "false"
}

# Attached parameter group
# Probably should be imported to generate the configuration
# import or generate this separately with additonal db variables
# parameter_group_name = "testdb-log-bin-trust-function-creators"

# Ec2 /Autoscaling Groups Variables

# change ssh CIDR to your host public ip or openvpn for example or bastion station

variable "SSH_CIDR_WEB_SERVER" {
  description = "CIDR block to access web server via ssh"
  default     = "0.0.0.0/0"
}
variable "SSH_CIDR_APP_SERVER" {
  description = "CIDR block to access app server via ssh"
  default     = "0.0.0.0/0"
}
variable "WEB_SERVER_INSTANCE_TYPE"{
  description = "Web server instance type"
  default     = "t2.micro"
}
variable "APP_SERVER_INSTANCE_TYPE"{
  description = "App server instance type"
  default     = "t2.micro"
}
variable "USER_DATA_FOR_WEBSERVER" {
  description = "Boot strap script to install application on web server"
  default     = "./userdata_code/web.sh"
}
variable "USER_DATA_FOR_APPSERVER" {
  description = "Boot strap script to install application on app server"
  default     = "./userdata_code/app.sh"
}
variable "PEM_FILE_APPSERVERS" {
  description = "Pem key to be able to access appserver after launch"
  default     = "sta-acc-only"
}
variable "PEM_FILE_WEBSERVERS" {
  description = "Pem key to be able to access webserver after launch"
  default     = "sta-acc-only"
}

# VPC Variables
variable "VPC_CIDR_BLOCK" {
  description = "Commondb VPC CIDR block "
  default     = "10.12.0.0/16"
}

# vpc public subnets
variable "VPC_PUBLIC_SUBNET1_CIDR_BLOCK" {
  description = "Public subnet 1 for ... "
  default     = "10.12.1.0/24"
}
variable "VPC_PUBLIC_SUBNET2_CIDR_BLOCK" {
  description = "Public subnet 2 for ..."
  default     = "10.12.2.0/24"
}
variable "VPC_PUBLIC_SUBNET3_CIDR_BLOCK" {
  description = "Public subnet 3 for ..."
  default     = "10.12.3.0/24"
}
# vpc private subnets
variable "VPC_PRIVATE_SUBNET1_CIDR_BLOCK" {
  description = "Private subnet 1 for ..."
  default     = "10.12.4.0/24"
}
variable "VPC_PRIVATE_SUBNET2_CIDR_BLOCK" {
  description = "Private subnet 2 for ..."
  default     = "10.12.5.0/24"
}
variable "VPC_PRIVATE_SUBNET3_CIDR_BLOCK" {
  description = "Private subnet 3 for ..."
  default     = "10.12.6.0/24"
}

