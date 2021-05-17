/******************************************
  Audit Logs - IAM
*****************************************/

resource "google_organization_iam_audit_config" "org_config" {
  count   = var.data_access_logs_enabled && var.parent_folder == "" ? 1 : 0
  org_id  = var.org_id
  service = "allServices"

  audit_log_config {
    log_type = "DATA_READ"
  }
  audit_log_config {
    log_type = "DATA_WRITE"
  }
  audit_log_config {
    log_type = "ADMIN_READ"
  }
}

resource "google_folder_iam_audit_config" "folder_config" {
  count   = var.data_access_logs_enabled && var.parent_folder != "" ? 1 : 0
  folder  = "folders/${var.parent_folder}"
  service = "allServices"

  audit_log_config {
    log_type = "DATA_READ"
  }
  audit_log_config {
    log_type = "DATA_WRITE"
  }
  audit_log_config {
    log_type = "ADMIN_READ"
  }
}

resource "google_project_iam_member" "audit_log_bq_user" {
  project = module.org_audit_logs.project_id
  role    = "roles/bigquery.user"
  member  = "group:${var.audit_data_users}"
}

resource "google_project_iam_member" "audit_log_bq_data_viewer" {
  project = module.org_audit_logs.project_id
  role    = "roles/bigquery.dataViewer"
  member  = "group:${var.audit_data_users}"
}

/******************************************
  Billing BigQuery - IAM
*****************************************/

# resource "google_project_iam_member" "billing_bq_user" {
#   project = module.org_billing_logs.project_id
#   role    = "roles/bigquery.user"
#   member  = "group:${var.billing_data_users}"
# }

# resource "google_project_iam_member" "billing_bq_viewer" {
#   project = module.org_billing_logs.project_id
#   role    = "roles/bigquery.dataViewer"
#   member  = "group:${var.billing_data_users}"
# }

/******************************************
  Billing Cloud Console - IAM
*****************************************/

resource "google_organization_iam_member" "billing_viewer" {
  org_id = var.org_id
  role   = "roles/billing.viewer"
  member = "group:${var.billing_data_users}"
}
