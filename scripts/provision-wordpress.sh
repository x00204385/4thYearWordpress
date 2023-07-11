#!/bin/bash
#
# Mount EFS share and identify RDS end point
#
# Install required utilities
#
sudo apt update
sudo apt install -y nfs-common zip jq awscli stress
#
# Mount the EFS file system
#
region=$(curl -s http://169.254.169.254/latest/meta-data/placement/region)
#
efs_dns_name=$(aws efs describe-file-systems --region $region | jq -r ".FileSystems[].FileSystemId")
#
mount_point="${efs_dns_name}.efs.${region}.amazonaws.com"
#
sudo mkdir -p /var/www/html
sudo mount -t nfs -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport $mount_point:/ /var/www/html
#
# Find the RDS instance
#
rds_endpoint=$(aws rds describe-db-instances --region $region --query 'DBInstances[*].Endpoint.Address' --output text)
#
# Record this for debugging purposes
#
echo ${rds_endpoint} >/tmp/dbendpoint.out
#
# Install wordpress and associated software
#
sudo apt install -y apache2
sudo apt install -y php libapache2-mod-php php-mysql
sudo apt install -y mysql-server
#
sudo a2enmod rewrite
#
# Download and unpack the Wordpress software into /var/www/html/wordpress
#
wget https://wordpress.org/latest.tar.gz
sudo tar xf latest.tar.gz -C /var/www/html
#
# Create a configuration file for our Wordpress installation
#
sudo cp /var/www/html/wordpress/wp-config-sample.php /var/www/html/wordpress/wp-config.php
#
# Edit Wordpress configuration files configuration
#
cd /var/www/html/wordpress
sudo sed -i "s/database_name_here/wp/g" wp-config.php
sudo sed -i "s/username_here/wp_user/g" wp-config.php
sudo sed -i "s/password_here/Computing1/g" wp-config.php
sudo sed -i "s/localhost/${rds_endpoint}/g" wp-config.php
#
# Set permissions on directories
#
sudo chown -R www-data:www-data /var/www/html/
sudo chmod -R 755 /var/www/html/
#
# Install a home web page to show what region/AZ etc. we are running from
#
sudo mv /var/www/html/index.html /var/www/html/index.html.bak
sudo cat <<'EOF' >/var/www/html/index.php
<!DOCTYPE html>
<html>
<head>
    <title>Welcome to IAC4Fun!</title>
</head>
<body>
    <h1>Welcome to IAC4Fun!</h1>
    <?php
    $instance_id = file_get_contents('http://169.254.169.254/latest/meta-data/instance-id');
    $instance_ip = file_get_contents('http://169.254.169.254/latest/meta-data/local-ipv4');
    $availability_zone = file_get_contents('http://169.254.169.254/latest/meta-data/placement/availability-zone');
    $region = substr($availability_zone, 0, -1);
    echo "<p>Instance ID: $instance_id</p>";
    echo "<p>Instance IP: $instance_ip</p>";
    echo "<p>Region: $region</p>";
    echo "<p>Availability Zone: $availability_zone</p>";
    ?>
</body>
</html>
EOF
sudo systemctl restart apache2
