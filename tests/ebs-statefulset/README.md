# Test EBS driver integration
#
```ssh
kubectl apply -f statefulset.yaml
```
Confirm that pod is running and check that PVC has been created. Ensure PVC is bound. 

Tidy up by deleting the stateful set
```ssh
kubectl delete -f statefulset.yaml
```
And manually delete the PVC
```ssh
kubectl delete pvc www-www-0 -n default
```
