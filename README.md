
Terraform should create a scale set of 3 instances, including external load balancer with health checks, everything should be done via terraform tf/tfstate files

Try to use terraform modules to segregate resources by its types (compute, network)

Create golden image containing pre-installed HTTP server (Apache) with simple website inside

Every host should display server number/hostname to ensure that load balancer is working

User should be able to connect to the website in HA mode via external load balancer IP

Add firewall for accessing external load balancer from limiter IP addresses range and only for certain ports