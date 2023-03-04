
variable "vpc_values" {
  type = object({
    public_subnet_cidr_block  = list(string)
    private_subnet_cidr_block = list(string)
    vpc_cidr_block            = string
  })
}

# variable "ssm_values" {
#   type = object({
#     db_password = string
#     db_name     = string
#     db_username = string
#   })
# }

variable "rds_values" {
  type = object({

    db_engine            = string
    db_engine_version    = string
    db_instance_class    = string
    db_allocated_storage = string
  })
}




variable "db_server_values" {
  type = object({

    inbound_ports  = list(string)
    outbound_ports = list(string)

  })
}

variable "eks_values" {
  type = object({
        #variable "LOG_GROUP_NAME" {}
        LOGS_RETENTION_IN_DAYS = string
        VPC_ID = string
        # SECURITY_GROUP_IDS = list(string)
        # CLUSTER_SUBNET_IDS = list(string)
        ENABLE_ENDPOINT_PRIVATE_ACCESS = string
        ENABLE_ENDPOINT_PUBLIC_ACCESS= string
        PUBLIC_ACCESS_CIDRS= string
        CLUSTER_NAME = string
        KUBERNETES_VERSION = string
        LOGGING_TYPE = list(string)
        DESIRED_CAPACITY= string
        # NODE_GROUP_SUBNET_IDS= list (string)
        MAX_SIZE= string
        MIN_SIZE= string
        NODE_INSTANCE_TYPE= string
        CAPACITY_TYPE= string
        NODE_INSTANCE_TAGS= string

        TAGS= string
        COMMON_TAGS= string
  })
}
