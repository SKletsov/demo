resource "aws_eks_node_group" "node" {
  cluster_name    = aws_eks_cluster.aws_eks.name
  node_group_name = var.name_group
  node_role_arn   = aws_iam_role.eks_nodes.arn
  subnet_ids      = var.subnet_priv_id
  instance_types  = [var.kube_instance_types]

  scaling_config {
    desired_size = var.kube_min_node
    max_size     = var.kube_max_node
    min_size     = var.kube_min_node
  }

  update_config {
    max_unavailable = 2
  }


  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
  ]
  tags = {
    Name = var.name
  }
}

resource "aws_eks_cluster" "aws_eks" {
  name     =  var.name
  role_arn = aws_iam_role.eks_cluster.arn
  version  = var.kube_version

  vpc_config {
    //security_group_ids = [var.sg]
    subnet_ids = var.subnet_id
  }

  tags = {
    Name = var.name
  }
}