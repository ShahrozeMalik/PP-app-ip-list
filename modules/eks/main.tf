####### Control Plane Logging ####### 

resource "aws_cloudwatch_log_group" "cluster-logs" {
  name = "${var.eks_values.CLUSTER_NAME}-Log-Group"
  retention_in_days = var.eks_values.LOGS_RETENTION_IN_DAYS

  tags = {
    Name = "${var.eks_values.CLUSTER_NAME}-Log-Group"
  }
}
#######  EKS Cluster ####### 

resource "aws_eks_cluster" "eks" {
  name     = var.eks_values.CLUSTER_NAME
  # version  = "17.23.0" #var.eks_values.KUBERNETES_VERSION
  # cluster_version = "1.21.2"
  role_arn = aws_iam_role.cluster.arn
  enabled_cluster_log_types = var.eks_values.LOGGING_TYPE

  vpc_config {
    security_group_ids = [var.sg_output.db_sg]
    subnet_ids         = var.vpc_output.public_subnet
    endpoint_private_access = var.eks_values.ENABLE_ENDPOINT_PRIVATE_ACCESS
    endpoint_public_access  = var.eks_values.ENABLE_ENDPOINT_PUBLIC_ACCESS
    # public_access_cidrs     = var.vpc_output.public_cidrs
  }
#     tags = merge(
#     var.eks_values.COMMON_TAGS,
#     var.eks_values.TAGS,
#     {
#       "Name" = var.eks_values.CLUSTER_NAME
#     },
#   )

}

#######  EKS Node Group ####### 

resource "aws_eks_node_group" "eks-node-group" {
  cluster_name    = var.eks_values.CLUSTER_NAME
  node_group_name = "${var.eks_values.CLUSTER_NAME}-node-group"
  node_role_arn   = aws_iam_role.eks_node_group.arn
  subnet_ids      = var.vpc_output.public_subnet
  capacity_type   = var.eks_values.CAPACITY_TYPE

  scaling_config {
    desired_size = var.eks_values.DESIRED_CAPACITY
    max_size     = var.eks_values.MAX_SIZE
    min_size     = var.eks_values.MIN_SIZE
  }
    instance_types = [
    var.eks_values.NODE_INSTANCE_TYPE
  ]
  
  update_config {
    max_unavailable = 1
  }
    depends_on = [
    aws_eks_cluster.eks
  ]
#     tags = merge(
#     var.eks_values.COMMON_TAGS,
#     var.eks_values.NODE_INSTANCE_TAGS,
#     {
#         "kubernetes.io/cluster/${var.eks_values.CLUSTER_NAME}" = "owned"
#     },
#   )
}

resource "aws_iam_role" "eks_node_group" {
  name = "${var.eks_values.CLUSTER_NAME}-node-group-role"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "eks-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks_node_group.name
}

resource "aws_iam_role_policy_attachment" "eks-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks_node_group.name
}

resource "aws_iam_role_policy_attachment" "eks-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks_node_group.name
}




#######  EKS Cluster IAM Role ####### 
resource "aws_iam_role" "cluster" {
  name = "${var.eks_values.CLUSTER_NAME}-Cluster-Role"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "cluster_AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.cluster.name
}





