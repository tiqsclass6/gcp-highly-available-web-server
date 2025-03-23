variable "project_id" {
  description = "Your GCP Project ID"
  type        = string
}

variable "credentials_file" {
  description = "Path to your GCP service account key JSON file"
  type        = string
}

variable "region" {
  description = "GCP region"
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "GCP zone"
  type        = string
  default     = "us-central1-a"
}

variable "vpc_name" {
  description = "VPC name"
  type        = string
  default     = "ha-webserver-vpc"
}

variable "public_subnet_cidr" {
  description = "Public subnet CIDR"
  type        = string
  default     = "10.230.1.0/24" # Choose your Public Subnet CIDR
}

variable "public_ip_cidr" {
  description = "Your public IP address for SSH access"
  type        = string
}