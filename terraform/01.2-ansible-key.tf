resource "google_compute_project_metadata" "ansible_key" {
  metadata = {
    ssh-keys = <<EOF
      ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDSndD52NPag+Tq2H9BHO2xcwnOyeeWqxnEGtzZ76jbxwm4c/yg0Uu4uFCm57GV0+EbjfHvOdBCUB2FlTqlfInuL9A5oO5X9d7TbPVWOX0MIfkxhIpWkv5UBiCG49sFrjuhrdxM3nI9sSCY5nbcb552hr8HXnXAY5pGtJM/f46HQvgwF5aJ+2Yq9/WgzUpGMDvcXFt/sZXNKefL5sgQE04iY3FIRIP+du8kRRVvsWF/KS8ojp+ZBnUpLslc3SzLB2f6yDtG0kSaZscKamdgELQE0AZlCJSFhnhOIWU0RbN7KCTMSmSs7m3X3YZe/1sXe5ItZ0jEKqdZIUgSbcdr6A+5 ansible
    EOF
  }
}