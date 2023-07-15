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
## Load balancer provisioning

```sh
kubectl apply -f load_balancer
```

Verify in the AWS console that the load balancer has been created and that the target group is routing to the pod addresses directly.

```sh
kubectl get pods -n 6-example -o wide
kubectl get svc -n 6-example -o wide
```

Visit the address pointed to by the service.

## EBS Volume Provisioning (EFS CSI driver)

```sh
kubectl apply -f ebs-statefulset
kubectl get pods -w
kubectl get pvc,pv
```
Confirm that pod comes up and volume is created. Confirm volume using AWS console. 

# Deploying Wordpress
Based on [tutorial](https://aws.amazon.com/blogs/storage/running-wordpress-on-amazon-eks-with-amazon-efs-intelligent-tiering/)

```sh
kubectl apply -f ../wp/wordpress-deployment-us.yaml
```


