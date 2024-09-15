terraform {
  backend "gcs" {

    bucket = "abalabanovic-tf-state"
    prefix = "terraform/state"
    credentials = "default_key.json"
    
  }
}
