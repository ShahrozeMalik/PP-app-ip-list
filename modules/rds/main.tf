########## DB Subnet Group ###########
resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "db_subnet_group"
  subnet_ids = var.vpc_output.private_subnet
}

########## DB-Instance ###########
resource "aws_db_instance" "tf_db" {
  allocated_storage = var.rds_values.db_allocated_storage
  engine            = var.rds_values.db_engine
  engine_version    = var.rds_values.db_engine_version
  instance_class    = var.rds_values.db_instance_class
  db_name           = "testdb"            #Uncomment if you want to create a database
  username          = "admin"
  password          = "adminnnnnn1111"
  # parameter_group_name = "tf_db.mysql8.0"
  skip_final_snapshot    = true
  db_subnet_group_name   = aws_db_subnet_group.db_subnet_group.id
  vpc_security_group_ids = [var.sg_output.db_sg]
}

# ########## DB-Password ###########
# resource "aws_ssm_parameter" "dbpassword" {
#   name        = "/wp-tf/dbcredentials/dbpassword"
#   description = "database password"
#   type        = "SecureString"
#   value       = var.ssm_values.db_password

# }

# ########## DB-Name ###########
# resource "aws_ssm_parameter" "dbname" {
#   name        = "/wp-tf/dbcredentials/dbname"
#   description = "database name"
#   type        = "SecureString"
#   value       = var.ssm_values.db_name

# }

# ########## DB-Username ###########
# resource "aws_ssm_parameter" "dbusername" {
#   name        = "/wp-tf/dbcredentials/dbusername"
#   description = "database username"
#   type        = "SecureString"
#   value       = var.ssm_values.db_username

# }

########## DB-Endpoint ###########
# resource "aws_ssm_parameter" "endpoint" {
#   name        = "/wp-tf/dbcredentials/endpoint"
#   description = "databse endpoint"
#   type        = "SecureString"
#   value       = aws_db_instance.tf_db.endpoint

# }
