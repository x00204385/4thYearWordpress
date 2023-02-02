# 4thYearWordpress
Proof of concept work on installing Wordpress on AWS
# 2-February
Added rds.tf which creates a MySQL RDS instance with the wp database and wp_user. Tested setup of Wordpress on an EC2 instance running in 
a public subnet. Steps required:
- Run terraform apply to create the required infrastructure
- Login to instance and install required software: 
-   12  sudo apt install -y apache2
   13  sudo apt install -y php libapache2-mod-php php-mysql
   14  sudo apt install -y mysql-server
   15  sudo mysql -h wp-rdsdb.cwfnq7dkyjal.eu-west-1.rds.amazonaws.com -u wp_user -p
   16  cd /tmp
   17  wget https://wordpress.org/latest.tar.gz
   18  tar xvf latest.tar.gz
   19  sudo mv wordpress/ /var/www/html/
   20  cd /var/www/html/
   21  ls
   22  cd wordpress/
   23  sudo cp wp-config-sample.php wp-config.php
