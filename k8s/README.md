# EFS Service Account creation
```sh
kubectl apply -f efs-service-account.yaml
```

# Kubernetes dashboard deployment
```sh
kubectl apply -f eks-admin-service-account.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.7.0/aio/deploy/recommended.yaml
kubectl create token eks-admin -n kube-system | pbcopy
kubectl proxy
```
Then got to [weblink](http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/#/login)

# Deploy the Wordpress app

```ssh
kubectl apply -f wordpress-deployment.yaml
```
Get the URL for the load balancer:
```ssh
kubectl get svc wordpress
```

# Deploy the AWS Sample app
See [Retail Store Sample App](https://github.com/aws-containers/retail-store-sample-app) for details.

```ssh
kubectl apply -f https://raw.githubusercontent.com/aws-containers/retail-store-sample-app/main/dist/kubernetes/deploy.yaml
kubectl wait --for=condition=available deployments --all
```
Get the URL for the load balancer:

```ssh
kubectl get svc ui
```
