
resource "google_compute_network" "vpc" {

  name                    = var.vpc-name
  auto_create_subnetworks = var.auto_create_subnetwork

}

resource "google_compute_subnetwork" "custom_subnet1" {

  name          = var.subnet-name
  network       = google_compute_network.vpc.self_link
  region        = var.region
  ip_cidr_range = var.cidr-range

}

resource "google_compute_firewall" "firewall_rules" {

  for_each = var.firewall_rules

  name        = each.value.name
  description = each.value.description
  network     = google_compute_network.vpc.self_link

  allow {

    protocol = each.value.protocol
    ports    = each.value.ports
  }

  source_ranges = var.source_ranges
  target_tags   = each.value.target_tags
}


resource "google_compute_health_check" "http_health_check" {

  name               = var.http_health_check_name
  check_interval_sec = var.hc_check_interval
  timeout_sec        = var.hc_timeout_interval


  tcp_health_check {

    port = var.healt_check_port

  }

}


resource "google_compute_region_backend_service" "backend_service" {

  name                  = var.backend_service_name
  health_checks         = [google_compute_health_check.http_health_check.id]
  load_balancing_scheme = var.load_balancing_scheme
  region                = var.region

  protocol = upper(var.protocol_for_loadbalancer)

  backend {

    group          = var.instance-group-self-link
    balancing_mode = var.balancing_mode

  }
}

resource "google_compute_forwarding_rule" "forwarding_rule" {

  name                  = var.forwarding_rule
  load_balancing_scheme = var.load_balancing_scheme
  backend_service       = google_compute_region_backend_service.backend_service.id
  ip_protocol           = upper(var.protocol_for_loadbalancer)
  ports                 = var.ports_forwarding_rule
  network               = google_compute_network.vpc.id
  subnetwork            = google_compute_subnetwork.custom_subnet1.id
  region                = var.region



}

resource "google_compute_router" "router" {

  name    = var.router_name
  region  = var.region
  network = google_compute_network.vpc.id

}

resource "google_compute_router_nat" "router-nat" {

  name                               = var.nat_name
  router                             = google_compute_router.router.name
  region                             = var.region
  nat_ip_allocate_option             = var.nat_ip_allocate_option
  source_subnetwork_ip_ranges_to_nat = var.source_subnetwork_ip_ranges_to_nat


}

resource "google_compute_firewall" "egress" {

  name    = var.firewall_rule_internet_name
  network = google_compute_network.vpc.name

  allow {

    protocol = var.protocol_for_loadbalancer
    ports    = var.firewall_rule_internet_ports
  }

  direction          = var.firewall_rule_internet_direction
  destination_ranges = var.firewall_rule_internet_destination

}