variable "replica_count" {
  description = "Number of replicas of a pod to create"
  type        = number
}

variable "weaviate_replication_factor" {
  description = "Weaviate replication factor"
  type        = number
}

variable "affinity" {
  description = "Affinity rules for scheduling pods"
  type = object({
    podAntiAffinity = object({ requiredDuringSchedulingIgnoredDuringExecution = map(any) })
    address         = string
  })
}

variable "tolerations" {
  description = "Tolerations config"
  type        = list(any)
}

variable "volume_claim_templates" {
  description = "Templates for PVCs"
  type        = list(map(any)) # Can use objects as above
}
