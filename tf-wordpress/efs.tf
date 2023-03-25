
resource "aws_efs_file_system" "efsassets" {
  creation_token = "wordpress-POC"
  encrypted      = false
}

resource "aws_efs_mount_target" "efsmtpvsubnet" {
  count = length(local.public_subnets)

  file_system_id  = aws_efs_file_system.efsassets.id
  subnet_id       = local.public_subnets[count.index]
  security_groups = [aws_security_group.allow-efs.id]
}
