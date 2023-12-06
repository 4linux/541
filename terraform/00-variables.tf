locals {
  ssh_user         = "ansible"
  private_key_path = "./ansible-key"
}

variable "project" {
}

variable "region" {
  # default = "southamerica-east1"
  default = "us-east1"
}

variable "zone" {
  # default = "southamerica-east1-c"
  default = "us-east1-c"
}

variable "image" {
  default = "ubuntu-os-cloud/ubuntu-2004-lts"
}

variable "image-single-master" {
  default = "centos-cloud/centos7"
}

variable "vpc_name" {
  default = "cka-4linux"
}

variable "subnet_name" {
  default = "cka-4linux-subnet"
}

variable "subnet_range" {
  default = "172.16.1.0/24"
}

variable "private_ips" {
  type = map(string)
  default = {
    kube-single-master = "172.16.1.110"
    kube-single-node1 = "172.16.1.111"
    kube-single-node2 = "172.16.1.112"
  }
}

variable "instance_sizes" {
  description = "tamanhos de instancias para atender ao TR na AWS"
  type        = map(string)
  default = {
    cpu2ram4  = "e2-medium"
    cpu4ram16 = "e2-standard-4"
  }
}