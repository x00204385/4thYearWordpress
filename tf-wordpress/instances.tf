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

  user_data = <<-EOF
	#!/bin/bash
	sudo apt update -y 
	sudo apt install -y apache2 
	sudo apt install -y php libapache2-mod-php php-mysql
#	sudo apt install -y mysql-server
#	echo "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password by '${var.db_password}';" | mysql -u root 
#	echo "CREATE USER '${var.db_username}'@'%' IDENTIFIED WITH mysql_native_password BY '${var.db_password};" | mysql -u root --password=${var.db_password}
#	echo "CREATE USER 'wp_user'@localhost IDENTIFIED BY '${var.db_password}';" | mysql -u root --password=${var.db_password}
#	echo "CREATE DATABASE wp;" | mysql -u root --password=${var.db_password}
#	echo "GRANT ALL PRIVILEGES ON wp.* TO '${var.db_username}'@localhost WITH GRANT OPTION; FLUSH PRIVILEGES;"| mysql -u root --password=${var.db_password}
#	cd /tmp
#	wget https://wordpress.org/latest.tar.gz
#	tar xf latest.tar.gz
#	sudo mv wordpress /var/www/html
	EOF
}

