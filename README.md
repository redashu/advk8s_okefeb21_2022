# advk8s_okefeb21_2022

## Docker client and server arch 

### login from docker client machine 

<img src="cli.png">

### Some docker basic commands 

```
 docker  pull  oraclelinux:8.4  
8.4: Pulling from library/oraclelinux
a4df6f21af84: Pull complete 
Digest: sha256:b81d5b0638bb67030b207d28586d0e714a811cc612396dbe3410db406998b3ad
Status: Downloaded newer image for oraclelinux:8.4
docker.io/library/oraclelinux:8.4
[ashu@ip-172-31-95-240 ~]$ docker  pull   alpine 
Using default tag: latest
latest: Pulling from library/alpine
59bf1c3509f3: Already exists 
Digest: sha256:21a3deaa0d32a8057914f36584b5288d2e5ecc984380bc0118285c70fa8c9300
Status: Downloaded newer image for alpine:latest
docker.io/library/alpine:latest
[ashu@ip-172-31-95-240 ~]$ docker  images
REPOSITORY                               TAG       IMAGE ID       CREATED         SIZE
registry                                 2         9c97225e83c8   13 days ago     24.2MB
alpine                                   latest    c059bfaa849c   2 months ago    5.59MB
cr.portainer.io/portainer/portainer-ce   2.9.3     ad0ecf974589   3 months ago    252MB
oraclelinux                              8.4       97e22ab49eea   3 months ago    246MB
gcr.io/cadvisor/cadvisor                 latest    68c29634fe49   14 months ago   163MB
```

### accessing container shell 

```
docker  exec  -it   ashuc1  sh 
/ # whoami
root
/ # ls /
bin    dev    etc    home   lib    media  mnt    opt    proc   root   run    sbin   srv    sys    tmp    usr    var
/ # exit

```

### Image building using docker file 

<img src="dfile.png">

### building image 

```
cd  pythonapp/
[ashu@ip-172-31-95-240 pythonapp]$ ls
Dockerfile  oracle.py
[ashu@ip-172-31-95-240 pythonapp]$ docker  build  -t  ashupython:v1  . 
Sending build context to Docker daemon  3.584kB
Step 1/6 : FROM python
latest: Pulling from library/python
0c6b8ff8c37e: Pull complete 
412caad352a3: Pull complete 
e6d3e61f7a50: Pull complete 
461bb1d8c517: Pull complete 
808edda3c2e8: Pull complete 
724cfd2dc19b: Pull complete 
1bb6570cd7ac: Pull complete 
aca06d6d45b1: Pull complete 
678714351737: Pull complete 
Digest: sha256:f06f47e4bfbda3ba69c4e1ea304f5a3c2a48ee6399ab28c82369fc59eb89410e
Status: Downloaded newer image for python:latest
 ---> dfce7257b7ba
Step 2/6 : LABEL name=ashutoshh
 ---> Running in 305e66e2b872
Removing intermediate container 305e66e2b872
 ---> 997f80c9f243
Step 3/6 : LABEL email=ashutoshh@linux.com
 ---> Running in e0eceeed2152
Removing intermediate container e0eceeed2152
 ---> d1edae3bca5f
Step 4/6 : RUN mkdir /mycode
 ---> Running in 947585643f6b
Removing intermediate container 947585643f6b
 ---> 119b2911942e
Step 5/6 : COPY  oracle.py /mycode/
 ---> eac7d1938acb
Step 6/6 : CMD  ["python","/mycode/oracle.py"]
 ---> Running in 52d4f260cf87
Removing intermediate container 52d4f260cf87
 ---> 5d4016c34a84
Successfully built 5d4016c34a84
Successfully tagged ashupython:v1

```

### checkig images

```
docker  images
REPOSITORY                               TAG       IMAGE ID       CREATED              SIZE
mohitpython                              v1        5e8d139f0e8c   59 seconds ago       917MB
binapython                               v1        c5c47cbcc664   About a minute ago   917MB
swatipython                              v1        d31db012b6b0   About a minute ago   917MB
ashupython                               v1        5d4016c34a84   About a minute ago   917MB
manishpy                                 v1        c91d4f9af271   About a minute ago   917MB
python                                   latest    dfce7257b7ba   13 days ago          917MB

```

### creating container 

```
ocker  run -itd  --name  ashuc2  ashupython:v1 
063df8a7a74500180e5ea150d03d5d208d86a384dd5266f75c99e13ab25ee5e3
[ashu@ip-172-31-95-240 pythonapp]$ 
[ashu@ip-172-31-95-240 pythonapp]$ docker  ps
CONTAINER ID   IMAGE                                          COMMAND                  CREATED         STATUS                 PORTS                                                                                            NAMES
2983f58d5028   binapython:v1                                  "python /mycode/orac…"   3 seconds ago   Up 2 seconds                                                                                                            bina2
063df8a7a745   ashupython:v1                                  "python /mycode/orac…"   5 seconds ago   Up 4 seconds                                     
```


### checking logs and stats

```
39  docker  logs  ashuc2
   40  docker  logs  -f  ashuc2
   41  history 
   42  docker  stats

```


