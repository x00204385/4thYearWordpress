#/bin/bash
#
set +x
export AWS_PROFILE=tud-admin
export KUBE_CONFIG_PATH=~/.kube/config
terraform workspace select eu-west-1
terraform destroy -var-file eu-west-1.tfvars --auto-approve
terraform workspace select us-east-1
terraform destroy -var-file us-east-1.tfvars --auto-approve
