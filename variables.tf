variable "project_id" {
  type        = string
  description = "GCP Project ID"
}

variable "region" {
  type        = string
  default     = "us-central1"
}

variable "instance_name" {
  type        = string
}

variable "vpc_name" {
  type        = string
}

variable "subnet_name" {
  type        = string
}

variable "bucket_name" {
  type        = string
}

variable "bucket_name_state" {
  type        = string
  description = "Name of the GCS bucket for Terraform state"
}
