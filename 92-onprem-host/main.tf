resource "google_service_account" "compute_sa" {
  project      = var.project_id
  account_id   = "sample-sa"
  display_name = "Sample SA"
}

resource "google_project_iam_member" "compute_sa_roles" {
  for_each = toset(["roles/compute.admin"])
  project  = var.project_id
  role     = each.key
  member   = "serviceAccount:${google_service_account.compute_sa.email}"
}

resource "google_compute_instance" "host1" {
  #checkov:skip=CKV_GCP_32:Ensure Block Project-wide SSH keys is enabled for VM instances
  #checkov:skip=CKV_GCP_38:Ensure VM disks for critical VMs are encrypted with Customer Supplied Encryption Keys (CSEK)
  #checkov:skip=CKV_GCP_39:Ensure Compute instances are launched with Shielded VM enabled
  project      = var.project_id
  name         = var.hostname
  machine_type = "f1-micro"
  zone         = "${var.default_region1}-a"

  tags = ["allow-iap-ssh"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    subnetwork         = "sb-onprem-${var.default_region1}"
    subnetwork_project = var.project_id
    network_ip         = var.private_ip

  }

  service_account {
    email  = google_service_account.compute_sa.email
    scopes = ["cloud-platform"]
  }
}