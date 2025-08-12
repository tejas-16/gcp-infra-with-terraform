# Create VPC
resource "google_compute_network" "vpc_network" {
  name                    = var.vpc_name
  auto_create_subnetworks = false
}

# Create Subnet
resource "google_compute_subnetwork" "subnet" {
  name          = var.subnet_name
  ip_cidr_range = "10.0.0.0/24"
  region        = var.region
  network       = google_compute_network.vpc_network.id
}

# Create VM instance
resource "google_compute_instance" "vm_instance" {
  name         = var.instance_name
  machine_type = "e2-micro"
  zone         = "${var.region}-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network    = google_compute_network.vpc_network.id
    subnetwork = google_compute_subnetwork.subnet.id
    access_config {}
  }
}

# Create Storage Bucket
resource "google_storage_bucket" "bucket" {
  name     = var.bucket_name
  location = var.region
}
