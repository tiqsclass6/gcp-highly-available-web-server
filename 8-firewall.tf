resource "google_compute_firewall" "allow_health_check" {
  name    = "allow-health-check"
  network = google_compute_network.ha_vpc.name

  direction = "INGRESS"
  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["35.191.0.0/16", "130.211.0.0/22"]
  target_tags   = ["web-server"]
  description   = "Allow Google health checks"
}