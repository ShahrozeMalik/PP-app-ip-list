output "sg_output" {

  value = {
    db_sg        = aws_security_group.db_sg.id
  }
}



