data "google_compute_zones" "available" {
}

resource "google_compute_instance" "vm" { 
  count        = var.cantidad_mvs

  name         = "vm${count.index}"
  machine_type = "e2-medium"
  zone         = data.google_compute_zones.available.names[count.index % length(data.google_compute_zones.available.names)]

  tags = ["linux", "debian"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    network    = google_compute_network.vpc-mi-infra.name
    subnetwork = google_compute_subnetwork.subnet-mi-infra-1.name

    access_config {
    }
  }

  metadata = {
    proyecto  = var.proyecto
    proposito = var.proposito
  }

  service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  }
}