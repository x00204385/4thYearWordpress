
resource "aws_db_subnet_group" "wordpress-db-subnetgroup" {
  name = "wordpress-db-subnetgroup"
  # subnet_ids = [aws_subnet.private-subnet-1a.id, aws_subnet.private-subnet-1b.id]
  subnet_ids = module.vpc.private_subnets

  tags = {
    Name = "Wordpress DB subnet group"
  }
}


resource "aws_security_group" "allow-mysql" {
  name   = "allow-mysql"
  vpc_id = module.vpc.vpc_id
  tags = {
    Name    = "allow-mysql"
    Purpose = "wordpress-POC"
  }

}

# Ingress Security Port 3306
resource "aws_security_group_rule" "mysql_inbound_access" {
  from_port         = 3306
  protocol          = "tcp"
  security_group_id = aws_security_group.allow-mysql.id
  to_port           = 3306
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
}

# Create MySQL RDS instance
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance
#
resource "aws_db_instance" "wordpress-rds" {
  allocated_storage      = 20
  db_name                = "wp"
  identifier             = "wp-rdsdb"
  engine                 = "mysql"
  engine_version         = "8.0"
  storage_type           = "gp2"
  instance_class         = "db.t3.micro"
  username               = var.db_username
  password               = var.db_password
  skip_final_snapshot    = true
  db_subnet_group_name   = "wordpress-db-subnetgroup"
  vpc_security_group_ids = ["${aws_security_group.allow-mysql.id}"]
  publicly_accessible    = true

  # depends_on = [aws_db_subnet_group.wordpress-db-subnetgroup, aws_internet_gateway.internet-gw]
  depends_on = [aws_db_subnet_group.wordpress-db-subnetgroup, module.vpc]


  tags = {
    Name = "wordpress-internet-gw"
  }

}
