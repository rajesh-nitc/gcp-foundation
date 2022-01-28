terraform {
  backend "gcs" {
    bucket                      = "bkt-b-tfstate-e9c3"
    prefix                      = "terraform/projects/business_unit_1/shared"
    impersonate_service_account = "org-terraform@prj-b-seed-6949.iam.gserviceaccount.com"
  }
}
