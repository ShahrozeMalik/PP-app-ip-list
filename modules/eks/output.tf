output "eks_output" {

  value = {
    EKS_CLUSTER = aws_eks_cluster.eks
    EKS_CLUSTER_ARN = aws_eks_cluster.eks.arn
    EKS_CLUSTER_ENDPOINT = aws_eks_cluster.eks.endpoint
    EKS_CLUSTER_ID = aws_eks_cluster.eks.id
    # EKS_NODE_GROUP_ARN = aws_eks_node_group.eks-node-group[*].arn
    # EKS_NODE_GROUP_ID = aws_eks_node_group.eks-node-group[*].id
    # EKS_NODE_GROUP_STATUS = aws_eks_node_group.eks-node-group[*].status
  }

}