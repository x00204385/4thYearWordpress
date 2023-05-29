region                     = "us-east-1"
vpc_cidr_block             = "10.2.0.0/16"
public_subnet_cidr_blocks  = ["10.2.1.0/24", "10.2.3.0/24"]
private_subnet_cidr_blocks = ["10.2.2.0/24", "10.2.4.0/24"]
availability_zones         = ["us-east-1a", "us-east-1b"]
instance-ami               = "ami-007855ac798b5175e"
key-pair                   = "tud-aws-use"
primary                    = false
