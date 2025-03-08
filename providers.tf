################################################################################
# Providers
################################################################################


provider "aws" {
  region = var.region
  default_tags {
    tags = local.aws_default_tags
  }
}
# CHECK AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY or AWS_SESSION_TOKEN are set


provider "kubernetes" {
  host                   = data.aws_eks_cluster.main.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.main.certificate_authority[0].data)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    args        = ["eks", "get-token", "--cluster-name", var.eks_cluster_name]
  }
}
# CHECK aws cli has correct credentials configured and adequate permissions in the IAM policy


provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.main.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.main.certificate_authority[0].data)
    exec {
      api_version = "client.authentication.k8s.io/v1alpha1"
      command     = "aws"
      args        = ["eks", "get-token", "--cluster-name", var.eks_cluster_name]
    }
  }
}
# CHECK aws cli has correct credentials configured and adequate permissions in the IAM policy

# CHANGE: Instead of using user input here, I would use the id attribute of the cluster created
# by the EKS Cluster section
data "aws_eks_cluster" "main" {
  name = var.eks_cluster_name
}
