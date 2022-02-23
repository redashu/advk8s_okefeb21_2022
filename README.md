# k8s revision --

<img src="rev.png">

### api resources listing through curl 

<img src="api.png">

## auto generate YAML / JSON 

```
kubectl  run  ashuwebapp --image=docker.io/dockerashu/oracleweb:appv1  --port=80  --dry-run=client  -o yaml 
kubectl  run  ashuwebapp --image=docker.io/dockerashu/oracleweb:appv1  --port=80  --dry-run=client  -o json 
```

### Deploy pod yaml 

```
 kubectl apply -f web.yaml 
pod/ashuwebapp created
[ashu@ip-172-31-95-240 k8sapps]$ kubectl get  po
NAME          READY   STATUS    RESTARTS   AGE
ashuwebapp    1/1     Running   0          5s
mohitwebapp   1/1     Running   0          39s
[ashu@ip-172-31-95-240 k8sapps]$ kubectl get  po -o wide
NAME          READY   STATUS    RESTARTS   AGE   IP               NODE                            NOMINATED NODE   READINESS GATES
ashuwebapp    1/1     Running   0          16s   192.168.60.194   ip-172-31-89-245.ec2.internal   <none>           <none>
mohitwebapp   1/1     Running   0          50s   192.168.60.193   ip-172-31-89-245.ec2.internal   <none>           <none>
  

```

### additional info about pod 

```
 kubectl  describe  pod  ashuwebapp 
Name:         ashuwebapp
Namespace:    default
Priority:     0
Node:         ip-172-31-89-245.ec2.internal/172.31.89.245
Start Time:   Wed, 23 Feb 2022 04:58:45 +0000
Labels:       run=ashuwebapp
Annotations:  cni.projectcalico.org/containerID: 22d0f49ad7b61fba8b1a17e076bad1f60bf474e2451cee138cd26c96dfd4f8a2
              cni.projectcalico.org/podIP: 192.168.60.194/32
              cni.projectcalico.org/podIPs: 192.168.60.194/32
Status:       Running
IP:           192.168.60.194
IPs:
  IP:  192.168.60.194
```

