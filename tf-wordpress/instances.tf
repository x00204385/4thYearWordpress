# 
# Instance to run the backup of the wp database
#
resource "aws_instance" "wordpressinstance" {
  # count         = length(local.public_subnets)
  ami           = var.instance-ami
  instance_type = "t2.micro"
  subnet_id     = local.public_subnets[0]
  key_name      = "tud-aws"
  vpc_security_group_ids = [aws_security_group.allow-ssh.id, aws_security_group.allow-mysql.id]

  iam_instance_profile = "WordpressInstanceRole"

  user_data = file("../scripts/bru.sh")

  depends_on = [aws_db_instance.wordpress-rds]

  tags = {
    Name = "wordpress-backup"
  }
}



