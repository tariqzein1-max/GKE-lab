terraform {
  backend "gcs" {
    bucket = "tf-state-gke-lab-474404"
    prefix = "terraform/state"
  }
}
