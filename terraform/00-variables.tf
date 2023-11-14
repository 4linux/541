variable "project" {
}

variable "region" {
  default = "southamerica-east1"
}

variable "zone" {
  default = "southamerica-east1-c"
}

variable "vpc_name" {
  default = "cka-4linux"
}

variable "subnet_name" {
  default = "cka-4linux-br"
}

variable "subnet_range" {
  default = "172.16.1.0/24"
}

variable "instance_sizes" {
  description = "tamanhos de instancias para atender ao TR na AWS"
  type        = map(string)
  default = {
    cpu2ram4  = "e2-medium"
    cpu4ram16 = "e2-standard-4"
  }
}