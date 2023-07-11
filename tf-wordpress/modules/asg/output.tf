output "lb_endpoint" {
  description = "The DNS address of the load balancer that is created"
  value = aws_lb.tudproj-LB.dns_name
}

