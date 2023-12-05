resource "google_compute_instance" "kube_node1" {
  name         = "kube-node1"
  machine_type = var.instance_sizes["cpu2ram4"]
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = var.image
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.subnet_sp.self_link
    network_ip = "172.16.1.101"
    access_config {}
  }

  tags = ["kube-nodes"]

  allow_stopping_for_update = true
  deletion_protection       = false

  resource_policies = [google_compute_resource_policy.daily.self_link]

  provisioner "remote-exec" {
    inline = ["echo 'Wait until SSH is ready'"]

    connection {
      type        = "ssh"
      user        = local.ssh_user
      private_key = file(local.private_key_path)
      host        = self.network_interface.0.access_config.0.nat_ip
    }
  }

  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook  -u ${local.ssh_user} -i ${self.network_interface.0.access_config.0.nat_ip}, --private-key ${local.private_key_path} provision/ansible/kube-node1.yaml"
  }

  depends_on = [google_compute_instance.kube_master]

}

output "kube_node1_public_ip" {
  value = google_compute_instance.kube_node1.network_interface.0.access_config.0.nat_ip
}