resource "google_compute_network" "vpc-mi-infra" {
  name = "vpc-${lower(var.proyecto)}"
}

resource "google_compute_subnetwork" "subnet-mi-infra-1" {
  name          = "${var.region}-subnetwork-${lower(var.proyecto)}"
  ip_cidr_range = "10.10.1.0/24"
  region        = var.region
  network       = google_compute_network.vpc-mi-infra.id
  secondary_ip_range {
    range_name    = "tf-test-secondary-range-${lower(var.proyecto)}"
    ip_cidr_range = "192.168.10.0/24"
  }
}