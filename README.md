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


