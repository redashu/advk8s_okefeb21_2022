FROM oraclelinux:8.4 
# docker engine will be using this image from docker hub 
LABEL name=ashutoshh
LABEL email=ashutoshh@linux.com 
# optional field but you can use to share info 
RUN  yum  install python3 -y 
# installing python3 in this image yum is a software installer in OL 
RUN mkdir /mycode 
# to get shell inside container during image building time 
COPY  oracle.py /mycode/
# to copy data from docker Client to docker engine server during image build time
#CMD  ["python3","/mycode/oracle.py"]
ENTRYPOINT python3  /mycode/oracle.py
# to fix the default process of this image 
# that means using this image when someone create container it will be default process
# which will be running 