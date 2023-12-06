resource "google_compute_instance" "kube_multi_master2" {
  name         = "kube-multi-master2"
  machine_type = var.instance_sizes["cpu2ram2"]
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = var.image
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.subnet_sp.self_link
    network_ip = var.private_ips["kube-multi-master2"]
    access_config {}
  }

  tags = ["web", "kube-nodes"]

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
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook  -u ${local.ssh_user} -i ${self.network_interface.0.access_config.0.nat_ip}, --private-key ${local.private_key_path} provision/ansible/kube-multi-master2.yaml"
  }
  
}

output "kube_multi_master2_public_ip" {
  value = google_compute_instance.kube_multi_master2.network_interface.0.access_config.0.nat_ip
}