# KUbernetes big picture 

<img src="apis.png">

## to query kube apiserver from k8s client 

### step1 start proxy 

```
kubectl  proxy 

```

### step 2 use curl / postman tools to query api 

```
558  curl http://127.0.0.1:8001
  559  curl http://127.0.0.1:8001/apis/apps/v1
  560  curl http://127.0.0.1:8001/api/v1

```

### k8s cluster setup --

<img src="setup.png">

### multi tier app in k8s 

<img src="app1.png">

### cleaning up namespace --

```

[ashu@ip-172-31-95-240 images]$ kubectl delete all --all
pod "ashudb-7d87944bfb-rwvxj" deleted
deployment.apps "ashudb" deleted
replicaset.apps "ashudb-7d87944bfb" deleted
[ashu@ip-172-31-95-240 images]$ kubectl  get  cm 
NAME               DATA   AGE
ashuenv            1      24h
kube-root-ca.crt   1      45h
[ashu@ip-172-31-95-240 images]$ kubectl delete cm  ashuenv
configmap "ashuenv" deleted
[ashu@ip-172-31-95-240 images]$ kubectl get secret 
NAME                  TYPE                                  DATA   AGE
ashudbpass            Opaque                                1      17h
ashusec               kubernetes.io/dockerconfigjson        1      45h
default-token-mbhrj   kubernetes.io/service-account-token   3      45h
[ashu@ip-172-31-95-240 images]$ kubectl delete secret  ashudbpass ashusec 
secret "ashudbpass" deleted
secret "ashusec" deleted

```

### Deployment of multi-tier app --

### step 1 to deploy pv using hostPAth

```
kubectl apply -f  multi-tier-app/
persistentvolume/ashu-pv created
[ashu@ip-172-31-95-240 k8sapps]$ kubectl get  pv
NAME      CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS      CLAIM   STORAGECLASS   REASON   AGE
ashu-pv   2Gi        RWO            Retain           Available  

```

### create pvc 

```
[ashu@ip-172-31-95-240 k8sapps]$ kubectl get  pvc 
NAME         STATUS   VOLUME     CAPACITY   ACCESS MODES   STORAGECLASS   AGE
ashu-claim   Bound    mohit-pv   1Gi        RWO                           4m34s

```

### create secret 

```
 kubectl apply -f  multi-tier-app/
secret/ashudbsec created
persistentvolume/ashu-pv unchanged
persistentvolumeclaim/ashu-claim unchanged
[ashu@ip-172-31-95-240 k8sapps]$ kubectl  get secret
NAME                  TYPE                                  DATA   AGE
ashudbsec             Opaque                                1      11s
default-token-mbhrj   kubernetes.io/service-account-token   3      45h
```

### create deploy for DB --

```
kubectl apply -f . 
deployment.apps/ashudb created
secret/ashudbsec configured
persistentvolume/ashu-pv unchanged
persistentvolumeclaim/ashu-claim unchanged
```
### creating service for DB --

```
 kubectl get deploy 
NAME     READY   UP-TO-DATE   AVAILABLE   AGE
ashudb   1/1     1            1           26m
fire@ashutoshhs-MacBook-Air ~ % kubectl expose deploy  ashudb  --type ClusterIP  --port 3306  --dry-run=client -o yaml 
apiVersion: v1
kind: Service
metadata:
  creationTimestamp: null
  labels:
    app: ashudb
  name: ashudb
spec:
  ports:
  - port: 3306
    protocol: TCP
    targetPort: 3306
  selector:
    app: ashudb
  type: ClusterIP
status:
  loadBalancer: {}

```


### service name based communication -- with CoreDNS concept 

```
fire@ashutoshhs-MacBook-Air ~ % kubectl exec -it testpod1 -- sh       
/ # nslookup ashudb 
Server:		10.96.0.10
Address:	10.96.0.10:53

Name:	ashudb.ashu-project.svc.cluster.local
Address: 10.104.109.68

```

### CoreDNS understanding 

<img src="coredns.png">

### Create webapp which is having html / css /js as FRONTend -- and PHP as backend 

```
 kubectl create  deployment ashu-webapp  --image=wordpress:4.8-apache --port 80 --dry-run=client  -o yaml 
apiVersion: apps/v1
kind: Deployment
metadata:
  creationTimestamp: null
  labels:
    app: ashu-webapp
  name: ashu-webapp
spec:
  replicas: 1
  selector:
    matchLabels:
      app: ashu-webapp
  strategy: {}
  template:
    metadata:

```

### deploy after changes 

```
 kubectl get deploy 
NAME          READY   UP-TO-DATE   AVAILABLE   AGE
ashu-webapp   1/1     1            1           23s
ashudb        1/1     1            1           52m
fire@ashutoshhs-MacBook-Air ~ % kubectl get  po    
NAME                           READY   STATUS    RESTARTS   AGE
ashu-webapp-57b544d6d7-xdzhm   1/1     Running   0          31s
ashudb-67ccd95494-h7l9g        1/1     Running   0          53m
testpod1                       1/1     Running   0          17m

```

### creating service for webapp of NodePort type 

```
 kubectl  get deploy 
NAME          READY   UP-TO-DATE   AVAILABLE   AGE
ashu-webapp   1/1     1            1           13m
ashudb        1/1     1            1           65m
fire@ashutoshhs-MacBook-Air ~ % kubectl expose deploy  ashu-webapp  --type NodePort --port 80 --name websvc --dry-run=client  -o yaml 
apiVersion: v1
kind: Service
metadata:
  creationTimestamp: null
  labels:
    app: ashu-webapp
  name: websvc
spec:
  ports:
  - port: 80
    protocol: TCP
    targetPort: 80
  selector:
    app: ashu-webapp
  type: NodePort
status:
  loadBalancer: {}

```




