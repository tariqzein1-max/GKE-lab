# Deployer service account
resource "google_service_account" "gh_deployer" {
  account_id   = "gh-deployer"
  display_name = "GitHub Actions Deployer"
}

# Project number is needed for IAM principalSet path (used indirectly)
data "google_project" "current" {
  project_id = var.project_id
}

# Workload Identity Pool for GitHub
resource "google_iam_workload_identity_pool" "github" {
  workload_identity_pool_id = "github-pool"
  display_name              = "GitHub Pool"
  description               = "OIDC trust for GitHub Actions"
}

# OIDC Provider for GitHub Actions (scoped to your repo via attribute_condition)
resource "google_iam_workload_identity_pool_provider" "github" {
  workload_identity_pool_id          = google_iam_workload_identity_pool.github.workload_identity_pool_id
  workload_identity_pool_provider_id = "github-provider"
  display_name                       = "GitHub Provider"
  description                        = "Trust token.actions.githubusercontent.com"

  oidc {
    issuer_uri = "https://token.actions.githubusercontent.com"
  }

  # Map only what we need. 'repository' lets us filter to your repo.
  attribute_mapping = {
    "google.subject"       = "assertion.sub"
    "attribute.actor"      = "assertion.actor"
    "attribute.repository" = "assertion.repository"
  }

  # ✅ Option B: restrict at the provider to your repo
  attribute_condition = "attribute.repository == '${var.github_repo}'"
}

# Allow ONLY your repo to impersonate gh-deployer
# The principalSet path references the pool we just created.
resource "google_service_account_iam_binding" "wif_binding" {
  service_account_id = google_service_account.gh_deployer.name
  role               = "roles/iam.workloadIdentityUser"

  members = [
    "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.github.name}/attribute.repository/${var.github_repo}"
  ]
}

# Minimal GCP permissions for deployment
resource "google_project_iam_member" "ar_writer" {
  project = var.project_id
  role    = "roles/artifactregistry.writer"
  member  = "serviceAccount:${google_service_account.gh_deployer.email}"
}

resource "google_project_iam_member" "gke_admin" {
  project = var.project_id
  role    = "roles/container.admin"
  member  = "serviceAccount:${google_service_account.gh_deployer.email}"
}
