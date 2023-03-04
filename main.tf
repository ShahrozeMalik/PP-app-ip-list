module "vpc" {

  source     = "./modules/vpc"
  vpc_values = var.vpc_values

}

module "rds" {
  source     = "./modules/rds"
#   ssm_values = var.ssm_values
  vpc_output = module.vpc.vpc_output
  sg_output  = module.sg.sg_output
  rds_values = var.rds_values
}

module "sg" {
  source = "./modules/sg"
  vpc_id            = module.vpc.vpc_output.vpc_id
  db_server_values  = var.db_server_values
}

module "eks" {
  
    source = "./modules/eks"
    eks_values = var.eks_values
    vpc_output = module.vpc.vpc_output
    rds_output = module.rds.rds_output
    sg_output = module.sg.sg_output

}

module "ecr" {
  
    source = "./modules/ecr"
}
