# output "lb_endpoint" {
#   description = "The DNS address of the load balancer that is created"
#   value       = aws_lb.tudproj-LB.dns_name
# }

output "lb_zone_id" {
  description = "The zone id used by the load balancer"
  value                = aws_lb.tudproj-LB.zone_id
}


output "lb_dns_name" {
description = "The DNS name of the load balancer"
 value = aws_lb.tudproj-LB.dns_name  
}

