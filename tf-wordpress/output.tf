output "instance_ips" {
  description = "IP address of the backup instance"
  value       = join(",", aws_instance.bastion.*.public_ip)
}

# output "instance_dns" {
#   value = join(",", aws_instance.wordpressinstance.*.public_dns)
# }

output "rds_endpoint" {
  value = aws_db_instance.wordpress-rds.endpoint
}

output "lb_endpoint" {
  value = aws_lb.tudproj-LB.dns_name
}

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

output "aws_load_balancer_controller_arn" {
  value       = aws_iam_role.aws_load_balancer_controller.arn
}
