output "rds_output" {

  value = {
    db = aws_db_instance.tf_db.id

  }

}