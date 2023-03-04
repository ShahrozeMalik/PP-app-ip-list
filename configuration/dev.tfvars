vpc_values = {
  vpc_cidr_block            = "10.0.0.0/16"
  public_subnet_cidr_block  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidr_block = ["10.0.3.0/24", "10.0.4.0/24"]
}

# ssm_values = {
#   db_password = "admin123"
#   db_name     = "tfdb"
#   db_username = "admin"
# }

rds_values = {
  db_engine            = "mysql"
  db_engine_version    = "8.0"
  db_instance_class    = "db.t2.micro"
  db_allocated_storage = "10"
}


db_server_values = {
  inbound_ports  = ["3306"]
  outbound_ports = ["0"]

}

eks_values = {
    CLUSTER_NAME                    = "eksclusterrr"
    # CLUSTER_SUBNET_IDS              = ["subnet-0b33a191c74c1957b", "subnet-08a06a4552fd15ce4"]
    # SECURITY_GROUP_IDS              = ["sg-07953275dded48e"]
    LOGS_RETENTION_IN_DAYS          = 7
    ENABLE_ENDPOINT_PUBLIC_ACCESS   = true
    PUBLIC_ACCESS_CIDRS             = "0.0.0.0/0" 
    ENABLE_ENDPOINT_PRIVATE_ACCESS  = true
    KUBERNETES_VERSION              = "1.11"
    LOGGING_TYPE                    = ["api"]
    # NODE_GROUP_SUBNET_IDS           = ["subnet-03112b190e2c8966a", "subnet-08a06a4552fd15ce4"]
    CAPACITY_TYPE                   = "ON_DEMAND"
    DESIRED_CAPACITY                = 3
    MAX_SIZE                        = 3
    MIN_SIZE                        = 1
    NODE_INSTANCE_TYPE              = "t2.medium"
    NODE_INSTANCE_TAGS              = "ManagedBy = Terraform"
    TAGS                            = "EKS_TF"
    COMMON_TAGS                     = "EKS_TF"
    VPC_ID                          = ""
}