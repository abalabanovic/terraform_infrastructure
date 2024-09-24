
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

resource "google_compute_global_address" "lb_public_ip" {

  name        = var.lb_global_ip_name
  description = "Public ip for load balancer"

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
  http_health_check {

    port         = 80
    request_path = "/"

  }

}


resource "google_compute_backend_service" "backend_service" {

  name          = var.backend_service_name
  health_checks = [google_compute_health_check.http_health_check.id]

  port_name = "http"
  protocol  = "HTTP"

  backend {

    group = var.instance-group-self-link

  }
}



resource "google_compute_target_http_proxy" "target-http-proxy" {

  name    = var.target_http_name
  url_map = google_compute_url_map.url_map.id

}

resource "google_compute_url_map" "url_map" {

  name            = var.url_map_name
  default_service = google_compute_backend_service.backend_service.id
}

resource "google_compute_global_forwarding_rule" "forwarding_rule" {

  name                  = var.forwarding_rule
  target                = google_compute_target_http_proxy.target-http-proxy.id
  port_range            = var.http_port_number_string
  ip_address            = google_compute_global_address.lb_public_ip.id
  load_balancing_scheme = var.load_balancing_scheme

}
