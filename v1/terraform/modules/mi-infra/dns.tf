locals {
  public_ip_list = flatten([ for vm in google_compute_instance.vm: [
    for ni in vm.network_interface: [
      for ac in ni.access_config:
        ac.nat_ip
      ]
    ]
  ])
}

resource "google_dns_managed_zone" "mi-infra-zone-public" {
  name        = "${lower(var.proyecto)}-public-zone"
  dns_name    = "${lower(var.proyecto)}.community."
  description = "${var.proyecto} Public DNS zone"

  labels = {
    proyecto  = lower(var.proyecto)
    proposito = var.proposito 
  }
}

resource "google_dns_managed_zone" "mi-infra-zone-private" {
  name        = "${lower(var.proyecto)}-private-zone"
  dns_name    = "private.${lower(var.proyecto)}.community."
  description = "${var.proyecto} Private DNS zone"
  
  visibility = "private"
  private_visibility_config {
    networks {
      network_url = google_compute_network.vpc-mi-infra.id
    }
  }

  labels = {
    proyecto  = lower(var.proyecto)
    proposito = var.proposito 
  }
}

resource "google_dns_record_set" "mi-infra-test-public" {
  name = "test.${google_dns_managed_zone.mi-infra-zone-public.dns_name}"
  type = "A"
  ttl  = 86000

  managed_zone = google_dns_managed_zone.mi-infra-zone-public.name
  rrdatas      = local.public_ip_list

  depends_on = [google_compute_instance.vm]
}

resource "google_dns_record_set" "mi-infra-test-private" {
  count = var.cantidad_mvs

  name = "_${google_compute_instance.vm[count.index].name}.${google_dns_managed_zone.mi-infra-zone-private.dns_name}"
  type = "A"
  ttl  = 86000

  managed_zone = google_dns_managed_zone.mi-infra-zone-private.name
  rrdatas      = [google_compute_instance.vm[count.index].network_interface.0.network_ip]

  depends_on = [google_compute_instance.vm]
}