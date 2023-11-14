resource "google_compute_network" "vpc" {
  name = var.vpc_name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet_sp" {
  ip_cidr_range = var.subnet_range

  name    = var.subnet_name
  network = google_compute_network.vpc.self_link

  region = var.region
}

resource "google_compute_router" "router" {
  name    = format("%s-%s", var.vpc_name, "-router")
  region  = google_compute_subnetwork.subnet_sp.region
  network = google_compute_network.vpc.self_link

  bgp {
    asn = 64514
  }
}

resource "google_compute_router_nat" "nat" {
  name                               = "my-router-nat"
  router                             = google_compute_router.router.name
  region                             = google_compute_router.router.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}