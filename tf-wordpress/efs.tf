
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

#
# Resources required for EKS 
resource "aws_efs_file_system" "eks-efs" {
  creation_token = "WP-INT-FS"
  encrypted      = false

  tags = {
    Name = "EKS-efs"
  }
}

resource "aws_efs_access_point" "eks-efs-ap" {
  file_system_id = aws_efs_file_system.eks-efs.id

  posix_user {
    gid = 1000
    uid = 1000
  }

  root_directory {
    path = "/wordpress"

    creation_info {
      owner_gid   = 1000
      owner_uid   = 1000
      permissions = 777
    }
  }
}


resource "aws_efs_mount_target" "eks-mt" {
  count = length(local.public_subnets)

  file_system_id  = aws_efs_file_system.eks-efs.id
  subnet_id       = local.public_subnets[count.index]
  security_groups = [aws_security_group.allow-efs.id]
}
