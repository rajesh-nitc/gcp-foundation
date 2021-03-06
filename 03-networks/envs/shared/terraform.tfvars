org_id                    = "157305482127"
terraform_service_account = "org-terraform@prj-b-seed-6949.iam.gserviceaccount.com"
default_region1           = "us-central1"
default_region2           = "us-west1"
enable_hub_and_spoke      = true

domain = "onprem.budita.dev."

enable_dns_zone_private_googleapis = false
enable_dns_peering                 = false
enable_dns_forwarding              = false

target_name_server_addresses = ["10.2.0.2"]

allow_all_ingress_ranges = [
  "10.2.0.0/24", # onprem
]

allow_all_egress_ranges = [
  "10.2.0.0/24", # onprem

]