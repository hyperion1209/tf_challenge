################################################################################
# Local Variables
################################################################################

locals {
  aws_default_tags = merge(
    { "clusterName" : var.eks_cluster_name },
    var.aws_default_tags,
  )
  customer_identifier = trimprefix(var.eks_cluster_name, "wv-")
  # CHANGED customer_cluster_identifier = "prod-dedicated-enterprise"

  permanent_workspaces        = ["dev", "test", "prod"]
  stage                       = contains(local.permanent_workspaces, terraform.workspace) ? terraform.workspace : "alpha"
  customer_cluster_identifier = "${stage}-dedicated-enterprise"

}
