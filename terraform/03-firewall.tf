resource "google_compute_firewall" "allow_internal" {

  name    = "allow-internal"
  network = google_compute_network.vpc.self_link

  source_ranges = [var.subnet_range]

  allow {
    protocol = "all"
  }

  priority = 65534
  
}

resource "google_compute_firewall" "allow_k8s" {

  name    = "allow-k8s"
  network = google_compute_network.vpc.self_link

  source_tags = ["kube-nodes"]
  target_tags = ["kube-nodes"]

  allow {
    protocol = "all"
  }

  priority = 65533
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

  disabled = true
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

resource "google_compute_firewall" "allow_node_port" {

  name    = "allow-node-port"
  network = google_compute_network.vpc.self_link

  source_ranges = ["0.0.0.0/0"]
  target_tags = ["kube-nodes"]

  allow {
    protocol = "tcp"
    ports = ["31541"]
  }

  disabled = true

}

resource "google_compute_firewall" "allow_access_from_iap" {

  name    = "allow-access-from-iap"
  network = google_compute_network.vpc.self_link

  source_ranges = ["35.235.240.0/20"]

  allow {
    protocol = "tcp"
  }
}