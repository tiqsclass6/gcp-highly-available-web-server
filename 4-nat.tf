# resource "google_compute_router" "web_router" {
#   name    = "router-ha-webserver"
#   network = google_compute_network.ha_vpc.name
#   region  = var.region
# }

# resource "google_compute_router_nat" "nat" {
#   name                               = "cloud-nat-ha-webserver"
#   router                             = google_compute_router.web_router.name
#   region                             = var.region
#   nat_ip_allocate_option             = "AUTO_ONLY"
#   source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
# }