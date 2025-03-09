# TODO: refactor so this doesn't get copy/pasted
###############################################
## imports
################################################
data "aws_eks_cluster" "cluster" {
  name = module.eks_cluster.eks_cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks_cluster.eks_cluster_id
}
## network
data "aws_vpc" "vpc" {
  filter {
    name   = "tag:Name"
    values = ["${var.namespace}-${var.environment}-vpc"]
  }
}

## network
data "aws_subnets" "private" {
  filter {
    name = "tag:Name"
    values = [
      "${var.namespace}-${var.environment}-private-subnet-private-use1a",
      "${var.namespace}-${var.environment}-private-subnet-private-use1b"
    ]
  }
}
