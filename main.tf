# ADDED: Use an S3 backed with state file locking for multi-user access
terraform {
  backend "s3" {
    region         = "us-west-2"
    bucket         = "weaviate-xw5d6t4uytrg-state-bucket"
    key            = "my-project-terraform.tfstate"
    dynamodb_table = "weaviate-xw5d6t4uytrg-state-lock"
    encrypt        = true
  }
}

################################################################################
# EKS Cluster and VPC Configuration
################################################################################


# (Intentionally left blank for exercise)


################################################################################
# High Availability Setup for Weaviate
################################################################################


module "weaviate_helm" {
  source = "./modules/weaviate"
  # ... (existing configuration)


  # HA Setup
  replica_count = 2


  # Weaviate-specific configurations
  weaviate_replication_factor = 1


  # Node Affinity and Anti-Affinity (to spread pods across AZs)
  # CHECK cluster spans at least 2 AZs; if not use preferred instead of required
  affinity = {
    podAntiAffinity = {
      requiredDuringSchedulingIgnoredDuringExecution = [
        {
          labelSelector = {
            matchExpressions = [
              {
                key      = "app"
                operator = "In"
                values   = ["weaviate"]
              },
            ]
          },
          topologyKey = "topology.kubernetes.io/zone"
        },
      ]
    }
  }


  # Tolerations (if needed based on your taints setup)
  tolerations = [
    # Tolerations configuration here
  ]


  # Persistent Volume Claim Issue
  volume_claim_templates = [{
    metadata = {
      name = "weaviate-data"
    }
    spec = {
      accessModes = ["ReadWriteOnce"]
      resources = {
        requests = {
          storage = "10Gi"
        }
      }
    }
  }]


  depends_on = [
    kubernetes_namespace.weaviate-namespace
  ]
}


################################################################################
# Additional Modules and Resources
################################################################################


# What additional modules should be added here?
# Backend configuration
# Variable definitions added in their own file

################################################################################
# Kubernetes Namespace for Weaviate
################################################################################


resource "kubernetes_namespace" "weaviate-namespace" {
  metadata {
    name = var.namespace
  }
}
