#
# # https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/4.0.2
#
# Create the VPC, NAT gateway, internet gateway, routing tables and subnets
#
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "4.0.2"

  name = "wp"
  cidr = var.vpc_cidr_block

  azs = var.availability_zones

  private_subnets      = var.private_subnet_cidr_blocks
  private_subnet_names = ["private-subnet-1a", "private-subnet-1b"]
  private_subnet_tags = {
    # Required to support the AWS Load Balancer Controller
    "kubernetes.io/role/internal-elb"               = 1
    "kubernetes.io/cluster/${var.eks_cluster_name}" = "owned"
  }

  public_subnets      = var.public_subnet_cidr_blocks
  public_subnet_names = ["public-subnet-1a", "public-subnet-1b"]
  public_subnet_tags = {
    # Required to support the AWS Load Balancer Controller
    "kubernetes.io/role/elb"                        = 1
    "kubernetes.io/cluster/${var.eks_cluster_name}" = "owned"
  }


  enable_nat_gateway     = var.enable_nat_gateway
  single_nat_gateway     = true
  one_nat_gateway_per_az = false


  enable_dns_hostnames = true
  enable_dns_support   = true

  map_public_ip_on_launch = true

}

module "eks" {
  source = "./modules/eks"

  vpc_id       = module.vpc.vpc_id
  region       = var.region
  subnets      = concat(local.public_subnets, local.private_subnets)
  node_subnets = local.public_subnets
  key-pair     = var.key-pair
  suffix       = var.primary ? "eu" : "us"
}


module "asg" {
  source = "./modules/asg"

  vpc_id      = module.vpc.vpc_id
  region      = var.region
  lb_subnets  = local.public_subnets
  asg_subnets = local.public_subnets

  key-pair = var.key-pair
  security_group_ids = [aws_security_group.allow-ssh.id, aws_security_group.allow-http.id,
  aws_security_group.allow-https.id]
  instance-ami = var.instance-ami

  depends_on = [aws_db_instance.wordpress-rds, aws_efs_file_system.wordpress-efs]

}
