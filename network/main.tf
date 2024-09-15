
resource "google_compute_network" "vpc" {
  
  name = var.vpc-name
  auto_create_subnetworks = false

}

resource "google_compute_subnetwork" "custom_subnet1" {
  
  name = var.subnet-name
  network = google_compute_network.vpc.self_link
  region = var.region
  ip_cidr_range = var.cidr-range

}

resource "google_compute_firewall" "firewall_rules" {
  
    for_each = var.firewall_rules
    
    name =  each.value.name
    description =  each.value.description
    network = google_compute_network.vpc.self_link

    allow {
      
        protocol = each.value.protocol
        ports = each.value.ports
    }

    source_ranges = var.source_ranges
    target_tags = each.value.target_tags
}


resource "google_compute_health_check" "http_health_check" {

    name = "http-health-check"
    check_interval_sec = 30
    timeout_sec = 30
    http_health_check {

      port = 80
      request_path = "/"

    }
  
}


resource "google_compute_backend_service" "backend_service" {
  
  name = "backend-service"
  health_checks = [google_compute_health_check.http_health_check.id]

  port_name = "http"
  protocol = "HTTP"

  backend {
    
        group = var.instance-group-self-link
        
  }
}



resource "google_compute_target_http_proxy" "target-http-proxy" {
  
    name = "target-http-proxy"
    url_map = google_compute_url_map.url_map.id

}

resource "google_compute_url_map" "url_map" {

    name = "url-map"
    default_service = google_compute_backend_service.backend_service.id
}

resource "google_compute_global_forwarding_rule" "forwarding_rule" {

    name = "forwarding-rule"
    target = google_compute_target_http_proxy.target-http-proxy.id
    port_range = "80"
  
}
