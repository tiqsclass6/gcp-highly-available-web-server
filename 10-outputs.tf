output "load_balancer_ip" {
  value       = google_compute_global_address.web_ip.address
  description = "Public IP address of the load balancer"
}

output "load_balancer_url" {
  value       = "http://${google_compute_global_address.web_ip.address}"
  description = "URL to access the HA Web Server"
}

output "instance_group_console_url" {
  value       = "https://console.cloud.google.com/compute/instanceGroups/details/${var.region}/webserver-mig?project=${var.project_id}"
  description = "Console link to managed instance group"
}