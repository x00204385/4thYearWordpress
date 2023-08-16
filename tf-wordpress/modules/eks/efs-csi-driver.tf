

resource "helm_release" "aws_efs_csi_driver" {
  name       = "aws-efs-csi-driver"
  repository = "https://kubernetes-sigs.github.io/aws-efs-csi-driver/"
  chart      = "aws-efs-csi-driver"
  # version = "2.4.5"
  namespace = "kube-system"

  values = [<<EOF
  controller:
    serviceAccount:
      create: true
      name: efs-csi-controller-sa
      annotations:
        eks.amazonaws.com/role-arn: "arn:aws:iam::233945710018:role/eks-efs-csi-driver-${var.suffix}"
EOF
  ]

  depends_on = [
    aws_eks_node_group.private_nodes,
    aws_iam_role_policy_attachment.amazon_efs_csi_driver
  ]
}
