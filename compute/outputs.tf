output "instance_group_self_link" {

  value       = google_compute_instance_group_manager.instance_group_manager.instance_group
  description = "Instance group manager"

}

output "instance-group-name" {

  value = google_compute_instance_group_manager.instance_group_manager.name

}