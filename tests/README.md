# Provisioning cluster


```sh
terraform apply -var-file ${region}.tfvars --auto-approve 
aws eks update-kubeconfig --region ${region} --name demo
```
## Check that nodes are configured
```sh
kubectl get nodes -o wide
```

## Install the EFS CSI driver with helm
```sh
helm repo update aws-efs-csi-driver
helm upgrade -i aws-efs-csi-driver aws-efs-csi-driver/aws-efs-csi-driver \
    --namespace kube-system \
    --set controller.serviceAccount.create=false \
    --set controller.serviceAccount.name=efs-csi-controller-sa
```

### Create the K8S service account

```sh
kubectl apply -f k8s/efs-service-account.yaml
```

# Test the configuration of the cluster

## Static Provisioning
See the tests directory and the multiple-pods example.

```ssh
terraform output
```
Should provde the FSID
```
efs_id = "fs-0005e8f3b30f5086f"
```

Edit pv.yaml and add the file system id.

Deploy the example

```
kubectl apply -f specs/pv.yaml
kubectl apply -f specs/claim.yaml
kubectl apply -f specs/storageclass.yaml
```

Deploy the app1 and app2 pods. 
```
kubectl apply -f specs/pod1.yaml
kubectl apply -f specs/pod2.yaml
kubectl get pods --watch
```

Verify that data is being written to the volume.
```
kubectl exec -ti app1 -- tail /data/out1.txt
```

## Dynamic Provisioning
Change storageclass.yaml to have the correct file system id.

```sh
kubectl apply -f dynamic_provisioning/specs/storageclass.yaml
kubectl apply -f dynamic_provisioning/specs/pod.yaml
```

```sh
kubectl get pods
```

Also you can verify that data is written onto EFS filesystem:

```sh
kubectl exec -ti efs-app -- tail -f /data/out
```
# Load balancer provisioning

```sh
kubectl apply -f load_balancer
```

Verify in the AWS console that the load balancer has been created and that the target group is routing to the pod addresses directly.

```sh
kubectl get pods -n 6-example -o wide
kubectl get svc -n 6-example -o wide
```

Visit the address pointed to by the service.

# Deploying Wordpress
Based on [tutorial](https://aws.amazon.com/blogs/storage/running-wordpress-on-amazon-eks-with-amazon-efs-intelligent-tiering/)

-    Create access point in EFS volume
-    Add reference wordpress-deployment.yaml
-    Deploy the pods (MySQL and Wordpress)

```sh
kubectl apply -f wordpress-deployment.yaml
```


