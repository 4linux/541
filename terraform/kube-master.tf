resource "google_compute_instance" "kube_master" {
  name         = "kube-master"
  machine_type = var.instance_sizes["cpu2ram4"]
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.subnet_sp.self_link
    network_ip = "172.16.1.100"
    access_config{}
  }

#   metadata_startup_script = file("./scripts/provision-cicd-tools.sh")

  allow_stopping_for_update = true
  deletion_protection       = false

  resource_policies = [google_compute_resource_policy.daily.self_link]

}

output "kube_master_public_ip" {
  value = google_compute_instance.kube_master.network_interface.0.access_config.0.nat_ip
}