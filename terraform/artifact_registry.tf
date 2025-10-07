resource "google_artifact_registry_repository" "apps" {
  location      = var.region
  repository_id = var.ar_repo
  description   = "App images for GKE lab"
  format        = "DOCKER"

  depends_on = [google_project_service.services]
}
