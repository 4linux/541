resource "google_compute_firewall" "allow_internal" {

  name    = "allow-internal"
  network = google_compute_network.vpc.self_link

  source_ranges = [var.subnet_range]

  allow {
    protocol = "icmp"
  }

  allow {
    ports    = ["0-65535"]
    protocol = "tcp"
  }

  allow {
    ports    = ["0-65535"]
    protocol = "udp"
  }


  priority = 65534
}

resource "google_compute_firewall" "allow_default" {

  name    = "allow-default"
  network = google_compute_network.vpc.self_link

  source_ranges = ["0.0.0.0/0"]

  allow {
    protocol = "icmp"
  }
}

resource "google_compute_firewall" "allow_access_from_iap" {

  name    = "allow-access-from-iap"
  network = google_compute_network.vpc.self_link

  source_ranges = ["35.235.240.0/20"]

  allow {
    protocol = "tcp"
  }
}