data "aws_iam_policy" "externaldns_iam_policy" {
  arn = "arn:aws:iam::233945710018:policy/external-dns-policy"
}


data "aws_iam_policy_document" "external_dns" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(aws_iam_openid_connect_provider.eks.url, "https://", "")}:sub"
      values   = ["system:serviceaccount:kube-system:external-dns"]
    }

    principals {
      identifiers = [aws_iam_openid_connect_provider.eks.arn]
      type        = "Federated"
    }
  }
}

resource "aws_iam_role" "external_dns_iam_role" {
  assume_role_policy = data.aws_iam_policy_document.external_dns.json
  name               = "external_dns_iam_role-${var.suffix}"
}

resource "aws_iam_role_policy_attachment" "external_dns" {
  role       = aws_iam_role.external_dns_iam_role.name
  policy_arn = "arn:aws:iam::233945710018:policy/external-dns-policy"
}
