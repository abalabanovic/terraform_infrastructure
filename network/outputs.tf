output "network_name" {
  
    value = google_compute_network.vpc.name
    description = "VPC ID"

}

output "subnet_name" {
  
    value = google_compute_subnetwork.custom_subnet1.name
    description = "Subnet ID"

}