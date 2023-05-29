
resource "aws_efs_file_system" "wordpress-efs" {
  creation_token = "wordpress-POC"
  encrypted      = false

  tags = {
    Name = "wordpress-efs"
  }
}

resource "aws_efs_mount_target" "wordpress-mt" {
  count = length(local.public_subnets)

  file_system_id  = aws_efs_file_system.wordpress-efs.id
  subnet_id       = local.public_subnets[count.index]
  security_groups = [aws_security_group.allow-efs.id]
}
