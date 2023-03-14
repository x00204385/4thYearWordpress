# 4thYearWordpress
Proof of concept work on installing Wordpress on AWS
# 2-February
Added rds.tf which creates a MySQL RDS instance with the wp database and wp_user. Tested setup of Wordpress on an EC2 instance running in 
a public subnet. Steps required:
- Run terraform apply to create the required infrastructure
- Login to instance and install required software:  
```
sudo apt install -y apache2
sudo apt install -y php libapache2-mod-php php-mysql
sudo apt install -y mysql-server
sudo mysql -h wp-rdsdb.cwfnq7dkyjal.eu-west-1.rds.amazonaws.com -u wp_user -p
cd /tmp
wget https://wordpress.org/latest.tar.gz
tar xvf latest.tar.gz
sudo mv wordpress/ /var/www/html/
cd /var/www/html/wordpress
sudo cp wp-config-sample.php wp-config.php
```
- Edit wp-config.php and add the configuration data (username, db name, db password)
- In a browser, go to the wordpress site and install. Check that you can login and that posts update the database
# 14-February
Small refinements to above. Used for screencast of progress so far. Fixed bugs where user_data was not getting applied.
# 14-March
Simpler setup as the terraform installation configures what we need.
```
sudo mysql -h wp-rdsdb.cwfnq7dkyjal.eu-west-1.rds.amazonaws.com -u wp_user -p
cd /var/www/html/wordpress
sudo cp wp-config-sample.php wp-config.php
```
- Edit wp-config.php and add the configuration data (username, db name, db password)
- In a browser, go to the wordpress site and install. Check that you can login and that posts update the database



