resource "google_compute_instance_template" "web_template" {
  name         = "webserver-template"
  machine_type = "e2-medium"
  tags         = ["web-server"]

  disk {
    boot         = true
    source_image = "projects/ubuntu-os-cloud/global/images/family/ubuntu-2204-lts"
    auto_delete  = true
  }

  network_interface {
    network    = google_compute_network.ha_vpc.id
    subnetwork = google_compute_subnetwork.public_subnet.id
    access_config {}  # Assigns external IP
  }

  metadata_startup_script = <<-EOF
    #!/bin/bash
    apt update -y
    DEBIAN_FRONTEND=noninteractive apt install -y apache2
    echo "Welcome to HA Web Server on $(hostname)" > /var/www/html/index.html
    sed -i 's/Listen 127.0.0.1:80/Listen 0.0.0.0:80/' /etc/apache2/ports.conf
    systemctl restart apache2
    systemctl enable apache2
  EOF
}

resource "google_compute_instance_group_manager" "web_mig" {
  name               = "webserver-mig"
  base_instance_name = "webserver"
  zone               = var.zone

  version {
    instance_template = google_compute_instance_template.web_template.self_link
  }

  target_size = 2  # Initial desired size

  named_port {
    name = "http"
    port = 80
  }

  auto_healing_policies {
    health_check      = google_compute_health_check.web_health.self_link
    initial_delay_sec = 300
  }
}

resource "google_compute_autoscaler" "web_autoscaler" {
  name   = "webserver-autoscaler"
  zone   = var.zone
  target = google_compute_instance_group_manager.web_mig.id

  depends_on = [
    google_compute_instance_group_manager.web_mig
  ]

  autoscaling_policy {
    min_replicas    = 2
    max_replicas    = 5
    cooldown_period = 60

    cpu_utilization {
      target = 0.6
    }
  }
}