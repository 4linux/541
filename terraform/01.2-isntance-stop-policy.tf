resource "google_compute_resource_policy" "daily" {
  name        = "gce-policy"
  region      = var.region
  description = "Stop instances"
  instance_schedule_policy {
    vm_stop_schedule {
      schedule = "00 23 * * *"
    }
    time_zone = "America/Bahia"
  }
}

