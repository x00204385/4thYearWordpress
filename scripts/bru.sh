#!/bin/bash
# Basic script to backup and restore the wp database. The database backup is copied to an s3 bucket. The instance in the secondary region
# copies from that that backup and loads to the local database in the region
#
# Install required software
sudo apt update
sudo apt install -y mysql-server awscli
region=$(curl -s http://169.254.169.254/latest/meta-data/placement/region)
# Find the RDS instance
rds_endpoint=$(aws rds describe-db-instances --region $region --query 'DBInstances[*].Endpoint.Address' --output text)

bucket="s3://wpbackup-x00204385"

timestamp=$(date +"%Y%m%d%H%M%S")

backup_file_basename=wp_backup
backup_file=/tmp/${backup_file_basename}

restore_file=${backup_file}

backup_cmd="/usr/bin/mysqldump --set-gtid-purged=OFF -h ${rds_endpoint} -u wp_user -pComputing1 wp >${backup_file}"

restore_cmd="mysql -h ${rds_endpoint} -u wp_user -pComputing1 wp < ${restore_file}"

case "$region" in
"eu-west-1")
    (
        echo "*/5 * * * * $backup_cmd && aws s3 cp $backup_file $bucket/"
    ) | crontab -
    ;;
"us-east-1")
    (
        echo "6/5 * * * * aws s3 cp $bucket/${backup_file_basename} /tmp && $restore_cmd"
    ) | crontab -
    ;;
esac
