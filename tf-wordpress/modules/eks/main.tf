locals {
  cluster_name = "demo"
}

resource "aws_iam_role" "demo" {
  name = "eks-cluster-demo-${var.suffix}"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "demo_amazon_eks_cluster_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.demo.name
}

resource "aws_eks_cluster" "demo" {
  name     = local.cluster_name
  role_arn = aws_iam_role.demo.arn

  vpc_config {

  subnet_ids = var.subnets
  }

  depends_on = [aws_iam_role_policy_attachment.demo_amazon_eks_cluster_policy]
}

resource "null_resource" "update_kubeconfig" {
  triggers = {
    always = timestamp()
  }

  depends_on = [aws_eks_cluster.demo]

  provisioner "local-exec" {
    interpreter = ["/bin/bash", "-c"]
    command     = <<EOT
      set -e
      echo 'Applying Auth ConfigMap with kubectl...'
      aws eks wait cluster-active --name '${local.cluster_name}' --region=${var.region}
      aws eks update-kubeconfig --name '${local.cluster_name}' --alias '${local.cluster_name}-${var.region}' --region=${var.region}
    EOT
  }
}

