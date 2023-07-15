# Provisioning infrastructure
Set the context first

```sh
./scripts/us-context.sh
```
Use Terraform to provision the infrastructure

```sh
terraform apply -var-file ${region}.tfvars --auto-approve 
```

## Check that nodes are configured
```sh
kubectl get nodes -o wide
```
## Set context in kubectl
```sh
kubectl config use-context demo-us-east-1
```

# Deploying Wordpress
Based on [tutorial](https://aws.amazon.com/blogs/storage/running-wordpress-on-amazon-eks-with-amazon-efs-intelligent-tiering/)

The deployment yaml is rendered by the build process. There is a file for each region. Can be deployed using kubectl. 
```sh
kubectl apply -f ../wp/wordpress-deployment-us.yaml
```

# Deploy sample app and dashboard
```sh
kubectl apply -k ../k8s/dashboard
kubectl create token eks-admin -n kube-system | pbcopy
kubectl proxy
```
Dashboard should be available at [localhost:8001/ui](http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/#/login)


