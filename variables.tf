# ADDED
variable "region" {
  description = "AWS region to deploy to"
  type        = string
}

variable "eks_cluster_name" {
  description = "Name of EKS cluster"
  type        = string

  validation {
    condition     = length(var.eks_cluster_name) > 0 && length(var.eks_cluster_name) <= 100
    error_message = "The EKS cluster name must be between 1 and 100 characters long."
  }
}

variable "aws_default_tags" {
  description = "Default tags to be added to AWS resources"
  type        = map(string)
}

variable "namespace" {
  description = "Kubernetes namespace"
  type        = string
}
