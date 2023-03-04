terraform {
  required_version = "1.3.9"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.30.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.13.1"
    }
    helm = {
      source = "hashicorp/helm"
      version = "2.5.1"
    }
  }
}


provider "aws" {
  region = "us-east-1"
}
data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.eks_output.EKS_CLUSTER.id
}

provider "kubernetes" {
  cluster_ca_certificate = try(base64decode(module.eks.eks_output.EKS_CLUSTER.certificate_authority.0.data), "")
  token                  = try(data.aws_eks_cluster_auth.cluster.token, "")
  host                   = try(module.eks.eks_output.EKS_CLUSTER.endpoint, "")
}

provider "helm" {
  kubernetes {
    cluster_ca_certificate = base64decode(module.eks.eks_output.EKS_CLUSTER.certificate_authority.0.data)
    host                   = module.eks.eks_output.EKS_CLUSTER.endpoint
    exec {
      api_version = "client.authentication.k8s.io/v1alpha1"
      command     = "aws"
      args = compact([
        "eks",
        "get-token",
        "--cluster-name",
        module.eks.eks_output.EKS_CLUSTER.name
      ])
    }
  }
}