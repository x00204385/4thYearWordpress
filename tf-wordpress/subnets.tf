# resource "aws_subnet" "public-subnet-1a" {
#   vpc_id                  = aws_vpc.main.id
#   cidr_block              = var.public_subnet_cidr_blocks[0]
#   map_public_ip_on_launch = "true"
#   availability_zone       = var.availability_zones[0]

#   tags = {
#     Name                                            = "public-subnet-1a"
#     "kubernetes.io/role/elb"                        = 1
#     "kubernetes.io/cluster/${var.eks_cluster_name}" = "owned"
#   }
# }

# resource "aws_subnet" "private-subnet-1a" {
#   vpc_id                  = aws_vpc.main.id
#   cidr_block              = var.private_subnet_cidr_blocks[0]
#   map_public_ip_on_launch = "false"
#   availability_zone       = var.availability_zones[0]

#   tags = {
#     Name                                            = "private-subnet-1a"
#     "kubernetes.io/role/internal-elb"               = 1
#     "kubernetes.io/cluster/${var.eks_cluster_name}" = "owned"
#   }
# }

# resource "aws_subnet" "public-subnet-1b" {
#   vpc_id                  = aws_vpc.main.id
#   cidr_block              = var.public_subnet_cidr_blocks[1]
#   map_public_ip_on_launch = "true"
#   availability_zone       = var.availability_zones[1]

#   tags = {
#     Name                                            = "public-subnet-1b"
#     "kubernetes.io/role/elb"                        = 1
#     "kubernetes.io/cluster/${var.eks_cluster_name}" = "owned"
#   }
# }

# resource "aws_subnet" "private-subnet-1b" {
#   vpc_id                  = aws_vpc.main.id
#   cidr_block              = var.private_subnet_cidr_blocks[1]
#   map_public_ip_on_launch = "false"
#   availability_zone       = var.availability_zones[1]

#   tags = {
#     Name                                            = "private-subnet-1b"
#     "kubernetes.io/role/internal-elb"               = 1
#     "kubernetes.io/cluster/${var.eks_cluster_name}" = "owned"

#   }
# }
