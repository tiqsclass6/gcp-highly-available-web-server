resource "google_compute_global_address" "web_ip" {
  name = "webserver-ip"
}

resource "google_compute_url_map" "web_map" {
  name            = "web-map"
  default_service = google_compute_backend_service.web_backend.self_link
}

resource "google_compute_target_http_proxy" "web_proxy" {
  name    = "web-proxy"
  url_map = google_compute_url_map.web_map.self_link
}

resource "google_compute_global_forwarding_rule" "web_frontend" {
  name       = "webserver-forwarding-rule"
  ip_address = google_compute_global_address.web_ip.address
  target     = google_compute_target_http_proxy.web_proxy.self_link
  port_range = "80"
}