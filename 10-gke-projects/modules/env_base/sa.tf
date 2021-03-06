locals {

  node_sa_default_roles = [
    "roles/logging.logWriter",
    "roles/storage.objectViewer",
    "roles/monitoring.metricWriter",
    "roles/stackdriver.resourceMetadata.writer",
    "roles/monitoring.viewer"
  ]

  node_sa_roles_cicd_project = [
    "roles/artifactregistry.reader",
    # "roles/storage.objectViewer", Required?
    # "roles/source.reader",
  ]

}

resource "google_service_account" "node_sa" {
  account_id = "sa-gke-node"
  project    = module.gke_project.project_id
}

# Allow nodes access to cloud operations
resource "google_project_iam_member" "node_sa_roles" {
  for_each = toset(local.node_sa_default_roles)
  project  = module.gke_project.project_id
  role     = each.value
  member   = "serviceAccount:${google_service_account.node_sa.email}"
}

# Allow nodes access to artifactory
resource "google_project_iam_member" "node_sa_cicd_roles" {
  for_each = toset(local.node_sa_roles_cicd_project)
  project  = var.app_cicd_project_id
  role     = each.value
  member   = "serviceAccount:${google_service_account.node_sa.email}"
}

# Allow cicd-sa to deploy on cluster
resource "google_project_iam_member" "cloudbuild_sa_role_gke_project" {
  project = module.gke_project.project_id
  role    = "roles/container.developer"
  member  = "serviceAccount:${var.cicd_sa}"
}

# Allow project sa to access tf state
#resource "google_storage_bucket_iam_member" "tf_state_bucket" {
#  bucket = var.bkt_tfstate
#  role   = "roles/storage.admin"
#  member = "serviceAccount:${module.gke_project.sa}"
#}