output "vpc_output" {

  value = {
    vpc_id         = aws_vpc.wp-tf_Vpc.id
    public_subnet  = aws_subnet.public-subnet.*.id
    private_subnet = aws_subnet.private-subnet.*.id
  }
}



