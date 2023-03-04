######### DataBase-Server Security Group ###########

resource "aws_security_group" "db_sg" {

  vpc_id = var.vpc_id

  dynamic "ingress" {
    for_each = var.db_server_values.inbound_ports
    content {
      from_port       = ingress.value
      to_port         = ingress.value
      protocol        = "tcp"
      cidr_blocks     = ["0.0.0.0/0"]
      # security_groups = [aws_security_group.appserver_sg.id]

    }
  }
  dynamic "egress" {
    for_each = var.db_server_values.outbound_ports
    content {
      from_port        = egress.value
      to_port          = egress.value
      protocol         = -1
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]

    }
  }
}