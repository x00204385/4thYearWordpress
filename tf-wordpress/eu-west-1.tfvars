region                     = "eu-west-1"
vpc_cidr_block             = "10.1.0.0/16"
public_subnet_cidr_blocks  = ["10.1.1.0/24", "10.1.3.0/24"]
private_subnet_cidr_blocks = ["10.1.2.0/24", "10.1.4.0/24"]
availability_zones         = ["eu-west-1a", "eu-west-1b"]
#instance-ami              = "ami-00aa9d3df94c6c354" 	Jammy. Has the problem with kernel reboot required.
instance-ami = "ami-0cc4e06e6e710cd94"
key-pair     = "tud-aws"
primary      = true


