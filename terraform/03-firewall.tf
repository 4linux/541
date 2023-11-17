resource "google_compute_firewall" "allow_internal" {

  name    = "allow-internal"
  network = google_compute_network.vpc.self_link

  source_ranges = [var.subnet_range, "192.168.0.0/16", "10.96.0.0/12"]

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

resource "google_compute_firewall" "allow_all_ssh_only_to_ansible" {

  name    = "allow-ssh"
  network = google_compute_network.vpc.self_link

  source_ranges = ["0.0.0.0/0"]


  allow {
    protocol = "tcp"
    ports = ["22"]
  }

  # disabled = true
}

resource "google_compute_firewall" "allow_web" {

  name    = "allow-web"
  network = google_compute_network.vpc.self_link

  source_ranges = ["0.0.0.0/0"]
  target_tags = ["web"]

  allow {
    protocol = "tcp"
    ports = ["8080"]
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

resource "google_compute_firewall" "allow_tjba" {

  name    = "allow-tjba"
  network = google_compute_network.vpc.self_link

  source_ranges = ["168.228.243.22/32", "168.228.243.29/32", "191.178.108.46/32"]

  allow {
    protocol = "all"
  }
}