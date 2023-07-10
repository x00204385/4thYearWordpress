locals {
  cluster_name = "demo"
}

resource "aws_iam_role" "demo" {
  name = "eks-cluster-demo"

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
  name     = "demo"
  role_arn = aws_iam_role.demo.arn

  vpc_config {
    # subnet_ids = [
    #   aws_subnet.public-subnet-1a.id,
    #   aws_subnet.private-subnet-1a.id,
    #   aws_subnet.public-subnet-1b.id,
    #   aws_subnet.private-subnet-1b.id
    # ]
  subnet_ids = concat(module.vpc.public_subnets, module.vpc.private_subnets)
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
      aws eks update-kubeconfig --name '${local.cluster_name}' --region=${var.region}
    EOT
  }
}

