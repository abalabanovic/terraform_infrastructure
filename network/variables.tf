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


variable "load_balancing_scheme" {

  type        = string
  description = "Define load balancing scheme"

}

variable "healt_check_port" {

  type    = number
  default = 80

}

variable "healt_check_request_path" {

  type = string

}

variable "backend_service_port_name" {

  type    = string
  default = "http"

}

variable "router_name" {

  type        = string
  description = "Name for router"

}

variable "nat_name" {

  type        = string
  description = "NAT name"

}

variable "nat_ip_allocate_option" {

  type    = string
  default = "AUTO_ONLY"

}

variable "source_subnetwork_ip_ranges_to_nat" {

  type    = string
  default = "ALL_SUBNETWORKS_ALL_IP_RANGES"

}

variable "balancing_mode" {

  type    = string
  default = "CONNECTION"

}

variable "protocol_for_loadbalancer" {

  type = string

}

variable "ports_forwarding_rule" {

  type    = list(string)
  default = ["80"]

}

variable "firewall_rule_internet_name" {

  type = string

}

variable "firewall_rule_internet_ports" {

  type = list(string)

}

variable "firewall_rule_internet_direction" {

  type = string

}

variable "firewall_rule_internet_destination" {

  type    = list(string)
  default = ["0.0.0.0/0"]

}