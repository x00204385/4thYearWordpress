locals {
  public_subnets  = [aws_subnet.public-subnet-1a.id, aws_subnet.public-subnet-1b.id]
  private_subnets = [aws_subnet.private-subnet-1a.id, aws_subnet.private-subnet-1b.id]
  servers         = ["s1", "s2"]
}

resource "aws_instance" "wordpressinstance" {
  count                  = 1
  ami                    = var.instance-ami
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public-subnet-1a.id
  key_name               = "tud-aws"
  vpc_security_group_ids = [aws_security_group.allow-ssh.id, aws_security_group.allow-http.id, aws_security_group.allow-https.id]

  tags = {
    Name = "wordpress-instance"
  }

}

