
provider "google" {

  credentials = file("default_key.json")
  project     = "gd-gcp-gridu-devops-t1-t2"
  region      = "us-central1"
  zone        = "us-central1-a"

}

module "network" {

  source      = "./network"
  vpc-name    = "vpc-abalabanovic"
  subnet-name = "subnet-abalabanovic"
  region      = "us-central1"
  cidr-range  = "10.0.1.0/24"
  #Health check ip ranges 35.191.0.0/16 130.211.0.0/22
  source_ranges            = ["178.221.66.14/32", "35.191.0.0/16", "130.211.0.0/22"]
  instance-group-self-link = module.compute.instance_group_self_link
  forwarding_rule          = "forwarding-rule"
  url_map_name             = "url-map"
  target_http_name         = "http-target-proxy"
  backend_service_name     = "backend-service"
  http_health_check_name   = "http-health-check"
  hc_check_interval        = 30
  hc_timeout_interval      = 30
  auto_create_subnetwork   = false
  lb_global_ip_name        = "lb-global-ip"
  load_balancing_scheme    = "EXTERNAL"


  firewall_rules = {

    http = {

      name        = "http-firewall-rule"
      description = "Allow HTTP trafic"
      protocol    = "tcp"
      ports       = ["80", "8080"]
      target_tags = ["http-allow"]


    }

    ssh = {

      name        = "ssh-firewall-rule"
      description = "Allow SSH traffic"
      protocol    = "tcp"
      ports       = ["22"]
      target_tags = ["ssh-allow"]

    }

  }
}

module "compute" {

  source          = "./compute"
  project-name    = "gd-gcp-gridu-devops-t1-t2"
  vpc_id          = module.network.network_name
  subnet_id       = module.network.subnet_name
  machine-type    = "e2-micro"
  instance-number = 3
  #Image with installed apache nad php showing hostname on web ui
  image-name          = "projects/gd-gcp-gridu-devops-t1-t2/global/images/abalabanovic-apache"
  region              = "us-central1"
  zone                = "us-central1-a"
  network-tags        = ["http-allow", "ssh-allow"]
  instance-group-name = "instance-group-manager"
  base-instance-name  = "instance"

}
