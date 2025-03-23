resource "google_compute_health_check" "web_health" {
  name = "health-check-webserver"

  http_health_check {
    port         = 80
    request_path = "/"
  }

  check_interval_sec  = 10
  timeout_sec         = 5
  healthy_threshold   = 2
  unhealthy_threshold = 2
}

resource "google_compute_backend_service" "web_backend" {
  name                  = "backend-webserver1"
  load_balancing_scheme = "EXTERNAL"
  protocol              = "HTTP"
  port_name             = "http"
  timeout_sec           = 10
  health_checks         = [google_compute_health_check.web_health.self_link]

  backend {
    group = google_compute_instance_group_manager.web_mig.instance_group
  }

  depends_on = [google_compute_health_check.web_health]
}