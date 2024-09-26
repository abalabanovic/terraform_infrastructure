locals {
  default_image_name = "projects/debian-cloud/global/images/debian-12-bookworm-v20240910"
  image_name_to_use  = var.image-name != "" ? var.image-name : local.default_image_name
}
