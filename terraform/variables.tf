# GCP project configuration
variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "region" {
  description = "GCP region"
  type        = string
  default     = "us-central1"
}

variable "cluster_name" {
  description = "GKE cluster name"
  type        = string
  default     = "gke-lab"
}

# Artifact Registry configuration
variable "ar_repo" {
  description = "Artifact Registry repository ID (name)"
  type        = string
  default     = "apps"
}

# GitHub OIDC configuration
variable "github_repo" {
  description = "GitHub repository used for OIDC trust binding (format: owner/repo)"
  type        = string
  default     = "tariqzein1-max/GKE-lab"
}
