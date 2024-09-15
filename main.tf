
provider "google" {
  
    credentials = file("default_key.json")
    project = "gd-gcp-gridu-devops-t1-t2"
    region = "us-central1"
    zone = "us-central1-a"

}

resource "google_compute_network" "andrej_vpc" {
  
    name = "andrej-vpc"
    project = "gd-gcp-gridu-devops-t1-t2"
    auto_create_subnetworks = true
}
