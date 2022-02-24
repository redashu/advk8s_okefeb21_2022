# k8s Master node component

## controllers 

<img src="controllers.png">

### api resources understanding 

<img src="api.png">

### COnfigMAP 

<img src="config.png">

### env 

```
% kubectl create configmap  ashuenv  --from-literal   key1=app1                  configmap/ashuenv created
fire@ashutoshhs-MacBook-Air ~ % kubectl get  cm 
NAME               DATA   AGE
ashuenv            1      43s
kube-root-ca.crt   1      21h

```

### deploy app 

```
kubectl apply -f  envdeploy.yaml 
deployment.apps/ashuapp created
[ashu@ip-172-31-95-240 k8sapps]$ kubectl get deploy 
NAME      READY   UP-TO-DATE   AVAILABLE   AGE
ashuapp   1/1     1            1           7s
[ashu@ip-172-31-95-240 k8sapps]$ kubectl get cm
NAME               DATA   AGE
ashuenv            1      4m7s
kube-root-ca.crt   1      21h
[ashu@ip-172-31-95-240 k8sapps]$ kubectl get  po
NAME                       READY   STATUS    RESTARTS   AGE
ashuapp-6758d9d668-j9pxb   1/1     Running   0          18s

```

### varify env 

```
kubectl exec -it  ashuapp-6758d9d668-j9pxb  -- env  
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
HOSTNAME=ashuapp-6758d9d668-j9pxb
TERM=xterm
deploy=app1

```

### creating nodeport service using expose 

```
kubectl  get deploy 
NAME      READY   UP-TO-DATE   AVAILABLE   AGE
ashuapp   1/1     1            1           6m9s
fire@ashutoshhs-MacBook-Air ~ % kubectl expose deploy  ashuapp  --type NodePort --port 1122 --target-port 80      --name ashusvc111 
service/ashusvc111 exposed
fire@ashutoshhs-MacBook-Air ~ % kubectl  get  svc 
NAME         TYPE       CLUSTER-IP     EXTERNAL-IP   PORT(S)          AGE
ashusvc111   NodePort   10.98.22.205   <none>        1122:30497/TCP   6s

```

### NP and LB svc 

```
 kubectl expose deploy ashuapp  --type LoadBalancer  --port 1234 --target-port 80  --name lbsvc 
service/lbsvc exposed
fire@ashutoshhs-MacBook-Air ~ % kubectl get  svc
NAME         TYPE           CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE
ashusvc111   NodePort       10.98.22.205    <none>        1122:30497/TCP   20m
lbsvc        LoadBalancer   10.103.200.48   <pending>     1234:31090/TCP   3s
```

### LB in OKE 

```
kubectl create deployment dd1  --image=dockerashu/oracleapp:24thfeb2022 --port 80 --dry-run=client -o yaml >oke.yaml 
learntechb@cloudshell:~ (us-phoenix-1)$ kubectl create cm ashuenv --from-literal key1=app1 
configmap/ashuenv created
learntechb@cloudshell:~ (us-phoenix-1)$ vim oke.yaml 
learntechb@cloudshell:~ (us-phoenix-1)$ kubectl apply -f  oke.yaml 
deployment.apps/dd1 created
learntechb@cloudshell:~ (us-phoenix-1)$ kubectl get deploy 
NAME   READY   UP-TO-DATE   AVAILABLE   AGE
dd1    0/1     1            0           11s
learntechb@cloudshell:~ (us-phoenix-1)$ kubectl get po -w
NAME                   READY   STATUS    RESTARTS   AGE
dd1-7fd57f4dd9-dsccd   1/1     Running   0          17s
^Clearntechb@cloudshell:~ (us-phoenix-1)$ kubectl get deploy 
NAME   READY   UP-TO-DATE   AVAILABLE   AGE
dd1    1/1     1            1           25s
learntechb@cloudshell:~ (us-phoenix-1)$ kubectl get cm 
NAME               DATA   AGE
ashuenv            1      2m4s
kube-root-ca.crt   1      27m
learntechb@cloudshell:~ (us-phoenix-1)$ kubectl expose deploy dd1 --type LoadBalancer --port 80 --name  mysvc1 
service/mysvc1 exposed
learntechb@cloudshell:~ (us-phoenix-1)$ kubectl get svc
NAME         TYPE           CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
kubernetes   ClusterIP      10.96.0.1       <none>        443/TCP        28m
mysvc1       LoadBalancer   10.96.101.184   <pending>     80:32709/TCP   10s
learntechb@cloudshell:~ (us-phoenix-1)$ kubectl get svc
NAME         TYPE           CLUSTER-IP      EXTERNAL-IP     PORT(S)        AGE
kubernetes   ClusterIP      10.96.0.1       <none>          443/TCP        29m
mysvc1       LoadBalancer   10.96.101.184   129.153.88.25   80:32709/TCP   61s
learntechb@cloudshell:~ (us-phoenix-1)$ 

```

### dashboard deployment 

```
 kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.5.0/aio/deploy/recommended.yaml
namespace/kubernetes-dashboard created
serviceaccount/kubernetes-dashboard created
service/kubernetes-dashboard created
secret/kubernetes-dashboard-certs created
secret/kubernetes-dashboard-csrf created

```

### URL of dashboard --

[k8s_dashboard](https://kubernetes.io/docs/tasks/access-application-cluster/web-ui-dashboard/)

### to access dashboard we change service type to NodePort or LB depends on cluster type 

```
 kubectl  -n  kubernetes-dashboard   get  deploy 
NAME                        READY   UP-TO-DATE   AVAILABLE   AGE
dashboard-metrics-scraper   1/1     1            1           67s
kubernetes-dashboard        1/1     1            1           69s
fire@ashutoshhs-MacBook-Air ~ % kubectl  -n  kubernetes-dashboard   get  po     
NAME                                         READY   STATUS    RESTARTS   AGE
dashboard-metrics-scraper-799d786dbf-82f9k   1/1     Running   0          73s
kubernetes-dashboard-546cbc58cd-d2qqf        1/1     Running   0          75s
fire@ashutoshhs-MacBook-Air ~ % kubectl  -n  kubernetes-dashboard   get  svc
NAME                        TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)    AGE
dashboard-metrics-scraper   ClusterIP   10.101.42.107   <none>        8000/TCP   81s
kubernetes-dashboard        ClusterIP   10.110.12.43    <none>        443/TCP    90s
fire@ashutoshhs-MacBook-Air ~ % kubectl  -n  kubernetes-dashboard   edit   svc kubernetes-dashboard
service/kubernetes-dashboard edited
fire@ashutoshhs-MacBook-Air ~ % kubectl  -n  kubernetes-dashboard   get  svc                       
NAME                        TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)         AGE
dashboard-metrics-scraper   ClusterIP   10.101.42.107   <none>        8000/TCP        2m2s
kubernetes-dashboard        NodePort    10.110.12.43    <none>        443:32461/TCP   2m11s

```

### get token for dashboard 

```
kubectl  -n  kubernetes-dashboard   get  secret 
NAME                               TYPE                                  DATA   AGE
default-token-4nvc8                kubernetes.io/service-account-token   3      5m11s
kubernetes-dashboard-certs         Opaque                                0      5m8s
kubernetes-dashboard-csrf          Opaque                                1      5m7s
kubernetes-dashboard-key-holder    Opaque                                2      5m6s
kubernetes-dashboard-token-svm5k   kubernetes.io/service-account-token   3      5m10s
fire@ashutoshhs-MacBook-Air ~ % 
fire@ashutoshhs-MacBook-Air ~ % 
fire@ashutoshhs-MacBook-Air ~ % kubectl  -n  kubernetes-dashboard  describe   secret  kubernetes-dashboard-token-svm5k 
Name:         kubernetes-dashboard-token-svm5k
Namespace:    kubernetes-dashboard
Labels:       <none>
Annotations:  kubernetes.io/service-account.name: kubernetes-dashboard
              kubernetes.io/service-account.uid: e17ccd4d-23a6-4db7-bd05-ac2c729787ac

```

### giving full access to dashboard 

```
kubectl  create  clusterrolebinding  dashboardaccess  --clusterrole=cluster-admin --serviceaccount=kubernetes-dashboard:kubernetes-dashboard 
clusterrolebinding.rbac.authorization.k8s.io/dashboardaccess created

```


