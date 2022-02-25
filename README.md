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

