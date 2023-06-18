# EFS Service Account creation
```sh
kubectl apply -f efs-service-account.yaml
```

# Kubernetes dashboard deployment
```sh
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.7.0/aio/deploy/recommended.yaml
kubectl create token eks-admin -n kube-system | pbcopy
kubectl proxy
```
Then got to [weblink](http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/#/login)


