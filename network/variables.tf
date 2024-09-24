variable "vpc-name" {

  type        = string
  description = "Name for VPC"

}

variable "subnet-name" {

  type        = string
  description = "Namer for custom subnet"
  default     = "custom-subnet1"

}

variable "region" {

  type        = string
  description = "Region name"
  default     = "us-central1"

}

variable "cidr-range" {

  type        = string
  description = "CIDR range for subnet"
  default     = "10.0.0.0/24"

}

variable "source_ranges" {

  type        = list(string)
  description = "IP addresses allowed for incoming traffic"
  default     = ["0.0.0.0/0"]

}

variable "instance-group-self-link" {

  description = "Instance group link"

}

variable "firewall_rules" {

  type = map(object({

    name        = string
    description = string
    target_tags = list(string)
    protocol    = string
    ports       = list(string)

  }))


}

variable "http_port_number_string" {

  type        = string
  description = "Defining port 80 for http"
  default     = "80"

}

variable "forwarding_rule" {

  type        = string
  description = "Forwarding rule name"
  default     = "forwarding-rule"

}

variable "url_map_name" {

  type        = string
  description = "Url map name"
  default     = "url-map"

}

variable "target_http_name" {

  type        = string
  description = "Target http proxy name"
  default     = "target-http-proxy"

}

variable "backend_service_name" {

  type        = string
  description = "Backend service name"

}

variable "http_health_check_name" {

  type        = string
  description = "HTTP health check name"
  default     = "http-health-check"

}

variable "hc_check_interval" {

  type        = number
  description = "Check interval for health check"
  default     = 30

}

variable "hc_timeout_interval" {

  type        = number
  description = "Timeout interval for healt check"
  default     = 30

}

variable "auto_create_subnetwork" {

  type        = bool
  description = "Boolean for auto creating subnetwork in vpc"
  default     = false

}

variable "lb_global_ip_name" {

  type        = string
  description = "Name for load balancer public ip"
  default     = "lb-public-ip"

}

variable "load_balancing_scheme" {

  type        = string
  description = "Define load balancing scheme"

}