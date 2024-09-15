
resource "google_compute_instance_template" "instance_template" {

    name = var.instance_template_name
    machine_type = var.machine-type

    disk {
      
        source_image = var.image-name

    }

    network_interface {
      
        network = var.vpc_id
        subnetwork = var.subnet_id

        access_config {
          
            #Leaving it empty will give us random public IP

        }   

    }   

    tags = var.network-tags

}

resource "google_compute_instance_group_manager" "instance_group_manager" {
  
  name = var.instance-group-name
  zone = var.zone
  base_instance_name = var.base-instance-name
 
  target_size = var.instance-number

  version {
    
    instance_template = google_compute_instance_template.instance_template.self_link
  }

  named_port {
    name = "http"
    port = 80
  }

}



