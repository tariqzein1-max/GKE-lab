output "cluster_name" {
  value       = google_container_cluster.gke.name
  description = "GKE cluster name"
}

output "wif_provider_resource" {
  value       = google_iam_workload_identity_pool_provider.github.name
  description = "Provider resource path for GitHub secret (projects/NNN/locations/global/workloadIdentityPools/.../providers/...)"
}

output "deployer_sa_email" {
  value       = google_service_account.gh_deployer.email
  description = "GitHub deployer service account"
}

output "artifact_registry_repo" {
  value       = "${var.region}-docker.pkg.dev/${var.project_id}/${google_artifact_registry_repository.apps.repository_id}"
  description = "Artifact Registry base path"
}
