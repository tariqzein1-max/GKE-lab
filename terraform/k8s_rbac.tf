# Namespace for the app
resource "kubernetes_namespace" "app" {
  metadata { name = "app" }
  depends_on = [google_container_cluster.gke]
}

# Give the Google SA cluster-admin inside Kubernetes
resource "kubernetes_cluster_role_binding" "gsa_admin" {
  metadata {
    name = "gh-deployer-cluster-admin"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }
  subject {
    kind      = "User"
    name      = google_service_account.gh_deployer.email
    api_group = "rbac.authorization.k8s.io"
  }

  depends_on = [google_container_cluster.gke]
}
