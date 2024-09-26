
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
  source_ranges             = ["178.221.66.14/32", "35.191.0.0/16", "130.211.0.0/22"]
  instance-group-self-link  = module.compute.instance_group_self_link
  forwarding_rule           = "forwarding-rule"
  url_map_name              = "url-map"
  target_http_name          = "http-target-proxy"
  backend_service_name      = "backend-service"
  http_health_check_name    = "http-health-check"
  hc_check_interval         = 30
  hc_timeout_interval       = 30
  auto_create_subnetwork    = false
  lb_global_ip_name         = "lb-global-ip"
  load_balancing_scheme     = "EXTERNAL"
  healt_check_port          = 80
  healt_check_request_path  = "/"
  backend_service_port_name = "http"


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
  //image-name             = "projects/gd-gcp-gridu-devops-t1-t2/global/images/abalabanovic-apache"
  image-name             = ""
  region                 = "us-central1"
  zone                   = "us-central1-a"
  network-tags           = ["http-allow", "ssh-allow"]
  instance-group-name    = "instance-group-manager"
  base-instance-name     = "instance"
  target_file_for_script = "index.php"
  startup_script_name    = "start_script.sh"

}
