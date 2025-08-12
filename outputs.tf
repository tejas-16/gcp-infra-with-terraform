output "instance_name" {
  description = "Name of the created VM instance"
  value       = google_compute_instance.default.name
}

output "instance_ip" {
  description = "Public IP of the created VM instance"
  value       = google_compute_instance.default.network_interface[0].access_config[0].nat_ip
}

output "bucket_name" {
  description = "Name of the created storage bucket"
  value       = google_storage_bucket.default.name
}

output "vpc_name" {
  description = "Name of the created VPC"
  value       = google_compute_network.default.name
}

output "subnet_name" {
  description = "Name of the created subnet"
  value       = google_compute_subnetwork.default.name
}
