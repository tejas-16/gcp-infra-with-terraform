terraform {
  required_version = ">= 1.5.0"

  backend "gcs" {
    bucket = "my-tf-state-bucket"  # Change to your GCS bucket for remote state
    prefix = "terraform/state"
  }

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

provider "google" {
  credentials = file(var.gcp_credentials_file)
  project     = var.project_id
  region      = var.region
}

# ------------------------
# VPC
# ------------------------
resource "google_compute_network" "vpc_network" {
  name                    = "my-vpc"
  auto_create_subnetworks = false
}

# ------------------------
# Subnet
# ------------------------
resource "google_compute_subnetwork" "subnet" {
  name          = "my-subnet"
  ip_cidr_range = "10.0.0.0/24"
  region        = var.region
  network       = google_compute_network.vpc_network.id
}

# ------------------------
# Compute Engine Instance
# ------------------------
resource "google_compute_instance" "vm_instance" {
  name         = "my-vm"
  machine_type = "e2-micro"
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.subnet.id
    access_config {}
  }

  tags = ["web", "dev"]
}

# ------------------------
# Cloud Storage Bucket (destroy-friendly)
# ------------------------
resource "google_storage_bucket" "bucket" {
  name          = "${var.project_id}-my-bucket"
  location      = var.region
  force_destroy = true
}

# ------------------------
# Outputs
# ------------------------
output "vm_external_ip" {
  value = google_compute_instance.vm_instance.network_interface[0].access_config[0].nat_ip
}

output "bucket_name" {
  value = google_storage_bucket.bucket.name
}
