locals {
  instance_name    = "$(terraform.workspace)-instance"
  public_subnets   = [aws_subnet.public-subnet-1a.id, aws_subnet.public-subnet-1b.id]
  private_subnets  = [aws_subnet.private-subnet-1a.id, aws_subnet.private-subnet-1b.id]
  private_key_path = "~/.ssh/${var.key-pair}.pem"
  servers          = ["s1", "s2"]
}