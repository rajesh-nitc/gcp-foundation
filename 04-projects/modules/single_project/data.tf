data "google_active_folder" "env" {
  display_name = "${var.folder_prefix}-${var.environment}"
  parent       = var.parent_folder != "" ? "folders/${var.parent_folder}" : "organizations/${var.org_id}"
}

data "google_projects" "projects" {
  count  = var.vpc_type == "" ? 0 : 1
  filter = "parent.id:${split("/", local.folder_id)[1]} labels.application_name=${var.vpc_type}-shared-vpc-host labels.environment=${var.environment} lifecycleState=ACTIVE"
}

data "google_compute_network" "shared_vpc" {
  count   = var.vpc_type == "" ? 0 : 1
  name    = "vpc-${local.env_code}-shared-${var.vpc_type}${local.shared_vpc_mode}"
  project = data.google_projects.projects[0].projects[0].project_id
}

data "google_compute_subnetwork" "shared_subnets" {
  for_each = var.vpc_type == "" ? [] : toset([var.default_region1, var.default_region2])
  project  = data.google_projects.projects[0].projects[0].project_id
  name     = "sb-${local.env_code}-shared-${var.vpc_type}-${each.key}-${var.business_code}"
  region   = each.key
}
