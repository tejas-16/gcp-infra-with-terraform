terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = "us-central1"
}

# Create VPC
resource "google_compute_network" "custom_vpc" {
  name                    = var.vpc_name
  auto_create_subnetworks = false
}

# Create Subnet
resource "google_compute_subnetwork" "custom_subnet" {
  name          = var.subnet_name
  ip_cidr_range = "10.0.0.0/24"
  region        = "us-central1"
  network       = google_compute_network.custom_vpc.id
}

# Create Instance
resource "google_compute_instance" "vm_instance" {
  name         = var.instance_name
  machine_type = "e2-micro"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.custom_subnet.id
    access_config {}
  }
}

# Create GCS Bucket
resource "google_storage_bucket" "bucket" {
  name          = var.bucket_name
  location      = "US"
  force_destroy = true
}
