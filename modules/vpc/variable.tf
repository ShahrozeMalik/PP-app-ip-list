variable "vpc_values" {
  type = object({
    public_subnet_cidr_block  = list(string)
    private_subnet_cidr_block = list(string)
    vpc_cidr_block            = string
  })
}