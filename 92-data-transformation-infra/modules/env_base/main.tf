locals {
  folder_id        = data.google_active_folder.env.name
  project_id       = data.google_project.transformation_project.project_id
  environment_code = element(split("", var.environment), 0)
  bkt_names        = [for bucket in toset(var.bucket_names) : "bkt-${local.environment_code}-${var.business_code}-tfn-${bucket}"]
  bkt_policy       = { for bucket in toset(local.bkt_names) : bucket => true }
  bkt_versioning   = { for bucket in toset(local.bkt_names) : bucket => true }
}

module "buckets_transformation" {
  source     = "terraform-google-modules/cloud-storage/google"
  version    = "2.0.0"
  project_id = local.project_id
  prefix     = ""

  names              = local.bkt_names
  location           = var.bucket_region
  storage_class      = "REGIONAL"
  bucket_policy_only = local.bkt_policy
  versioning         = local.bkt_versioning
}
