domains_to_allow                            = ["budita.dev"]
billing_data_users                          = "gcp-billing-admins@budita.dev"
audit_data_users                            = "gcp-security-admins@budita.dev"
org_id                                      = "157305482127"
billing_account                             = "014A32-6EFDA8-492638"
terraform_service_account                   = "org-terraform@prj-b-seed-6949.iam.gserviceaccount.com"
default_region                              = "us-central1"
scc_notification_name                       = "scc-notify"
enable_hub_and_spoke                        = false
data_access_logs_enabled                    = false
audit_logs_table_expiration_days            = 5
audit_logs_table_delete_contents_on_destroy = true