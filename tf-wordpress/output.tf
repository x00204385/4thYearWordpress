output "bastion_instance_ips" {
  description = "IP address of the bastion instance"
  value       = join(",", aws_instance.bastion.*.public_ip)
}

# output "instance_dns" {
#   value = join(",", aws_instance.wordpressinstance.*.public_dns)
# }

output "rds_endpoint" {
  value = aws_db_instance.wordpress-rds.endpoint
}


output "primary_nacl" {
  value       = module.vpc.default_network_acl_id
  description = "The ID of the default network ACL in the VPC"

}

output "vpc_id" {
  value       = module.vpc.vpc_id
  description = "Id of the VPC that was created"
}

output "efs_id" {
  value       = aws_efs_file_system.eks-efs.id
  description = "EFS ID for use with EKS PVCs"
}


output "cluster_status" {
  description = "Status of the EKS cluster. One of `CREATING`, `ACTIVE`, `DELETING`, `FAILED`"
  value       = module.eks.cluster_status
}

output "cluster_name" {
  description = "Name of the cluster"
  value       = module.eks.cluster_name
}

# output "lb_endpoint" {
#   value = module.asg.lb_endpoint
# }


output "lb_zone_id" {
  description = "The zone id used by the load balancer"
  value       = module.asg.lb_zone_id
}


output "lb_dns_name" {
  description = "The DNS name of the load balancer"
  value       = module.asg.lb_dns_name
}

output "eks_cluster_autoscaler_arn" {
  value = module.eks.eks_cluster_autoscaler_arn
}

# output "eks_wordpress_health_check" {
#   description = "The id of the health check used in DNS failover routing on EKS"
#   value = aws_route53_health_check.foo-health[0].id
# }

# output "elb_wordpress_health_check" {
#   description = "The id of the health check used in DNS failover routing on ASG/ELB"
#   value = aws_route53_health_check.primary-health[0].id
# }


# output "efs_dns_name" {
#   value = aws_efs_file_system.wordpress-efs.dns_name
# }

# output "application_endpoint" {
#   value = "https://${aws_lb.tudproj-LB.dns_name}/index.php"
# }

# output "asg_name" {
#   value       = aws_autoscaling_group.wpASG.name
#   description = "Name of the auto scaling group"
# }

# output "aws_load_balancer_controller_arn" {
#   value       = aws_iam_role.aws_load_balancer_controller.arn
# }
