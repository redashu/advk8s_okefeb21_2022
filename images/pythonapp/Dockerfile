FROM python
# docker engine will be using this image from docker hub 
LABEL name=ashutoshh
LABEL email=ashutoshh@linux.com 
# optional field but you can use to share info 
RUN mkdir /mycode 
# to get shell inside container during image building time 
COPY  oracle.py /mycode/
# to copy data from docker Client to docker engine server during image build time
CMD  ["python","/mycode/oracle.py"]
# to fix the default process of this image 
# that means using this image when someone create container it will be default process
# which will be running 