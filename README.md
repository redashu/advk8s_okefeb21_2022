# kubernetes Intro --

<img src="k8s.png">

### k8s arch 

### hardware and networking level 

<img src="arch.png">

### master node component which api-server 

<img src="api.png">

### kubectl to interact 

```
kubectl cluster-info  --kubeconfig  admin.conf 
Kubernetes control plane is running at https://172.31.91.6:6443
CoreDNS is running at https://172.31.91.6:6443/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy
```

### 

```
kubectl cluster-info  --kubeconfig  admin.conf 
Kubernetes control plane is running at https://172.31.91.6:6443
CoreDNS is running at https://172.31.91.6:6443/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy

To further debug and diagnose cluster problems, use 'kubectl cluster-info dump'.
[ashu@ip-172-31-95-240 images]$ kubectl get  nodes  --kubeconfig  admin.conf 
NAME            STATUS   ROLES                  AGE   VERSION
control-plane   Ready    control-plane,master   53m   v1.23.4
node1           Ready    <none>                 53m   v1.23.4
```

### copy kubeconfig file with right client side location 

```

[ashu@ip-172-31-95-240 images]$ mkdir  ~/.kube
mkdir: cannot create directory ‘/home/ashu/.kube’: File exists
[ashu@ip-172-31-95-240 images]$ 
[ashu@ip-172-31-95-240 images]$ cp -v admin.conf  ~/.kube/config 
‘admin.conf’ -> ‘/home/ashu/.kube/config’
[ashu@ip-172-31-95-240 images]$ 
[ashu@ip-172-31-95-240 images]$ 
[ashu@ip-172-31-95-240 images]$ kubectl get  nodes 
NAME            STATUS   ROLES                  AGE   VERSION
control-plane   Ready    control-plane,master   55m   v1.23.4
node1           Ready    <none>                 55m   v1.23.4
[ashu@ip-172-31-95-240 images]$ 

```

### ETCD -- 

<img src="etcd.png">

## container images will be deployed as POD --- in k8s 

<img src="contvspod.png">



