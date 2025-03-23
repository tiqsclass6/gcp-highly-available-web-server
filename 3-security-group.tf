resource "google_compute_firewall" "allow_http" {
  name    = "allow-http"
  network = google_compute_network.ha_vpc.name

  direction = "INGRESS"
  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["web-server"]
  description   = "Allow incoming HTTP traffic"
}

resource "google_compute_firewall" "allow_ssh" {
  name    = "allow-ssh"
  network = google_compute_network.ha_vpc.name

  direction = "INGRESS"
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = [var.public_ip_cidr]
  target_tags   = ["web-server"]
  description   = "Allow SSH from trusted IP"
}