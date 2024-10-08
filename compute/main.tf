
# Deploying test instance in same VPC to test internal load balancer

/*
resource "google_compute_instance" "test_instance" {

  machine_type = var.machine-type
  name         = "test-instance"
  zone         = var.zone

  tags = var.network-tags

  boot_disk {
    initialize_params {

      image = local.default_image_name

    }

  }

  network_interface {

    network    = var.vpc_id
    subnetwork = var.subnet_id

    access_config {

    }
  }


  metadata = {
    ssh-keys = "abalabanovic:${file("${path.module}/${"id_rsa.pub"}")}"
  }


}
*/

data "template_file" "startup_script" {

  template = file("${path.module}/${var.startup_script_name}")

  vars = {

    target_file = var.target_file_for_script

  }

}

resource "google_compute_instance_template" "instance_template" {

  name         = var.instance_template_name
  machine_type = var.machine-type

  metadata_startup_script = data.template_file.startup_script.rendered

  disk {

    source_image = local.image_name_to_use

  }

  network_interface {

    network    = var.vpc_id
    subnetwork = var.subnet_id

    # No "access_config" block, so no public IP will be assigned

  }

  tags = var.network-tags

}

resource "google_compute_instance_group_manager" "instance_group_manager" {

  name               = var.instance-group-name
  zone               = var.zone
  base_instance_name = var.base-instance-name

  target_size = var.instance-number

  version {

    instance_template = google_compute_instance_template.instance_template.self_link
  }

  named_port {
    name = var.instance_group_manager_named_port_name
    port = var.instance_group_manager_named_port_number
  }

}



