output "cluster_status" {
  description = "Status of the EKS cluster. One of `CREATING`, `ACTIVE`, `DELETING`, `FAILED`"
  value       = aws_eks_cluster.demo.status
}

output "cluster_name" {
  description = "The name of the EKS cluster"
  value       = aws_eks_cluster.demo.id
}
