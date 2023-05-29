#!/bin/bash
sudo apt update
sudo apt install -y nfs-common zip jq awscli
# Mount the EFS file system
region=$(curl -s http://169.254.169.254/latest/meta-data/placement/region)
efs_dns_name=$(aws efs describe-file-systems --region $region | jq -r ".FileSystems[].FileSystemId")
mount_point="${efs_dns_name}.efs.${region}.amazonaws.com"
sudo mkdir -p /mnt/efs
sudo mount -t nfs -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport $mount_point:/ /mnt/efs
# Find the RDS instance
sudo apt install -y mysql-server
aws rds describe-db-instances --region $region --query 'DBInstances[*].Endpoint.Address' --output text >/tmp/dbname.out
