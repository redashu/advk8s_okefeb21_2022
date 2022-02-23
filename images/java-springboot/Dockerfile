FROM oraclelinux:8.4 as STAGE1 
LABEL email=ashutoshh@linux.com
RUN yum install -y java-1.8.0-openjdk.x86_64 java-1.8.0-openjdk-devel.x86_64 maven 
RUN mkdir /webapp 
WORKDIR /webapp
# changing directory during image build time 
COPY .  . 
# source means data from Dockerfile location -- target means present working directory in build stage
# add / copy instruction will read .dockerignore file 
RUN mvn clean package 
# this will download maven libs and convert webapp code to war file 
#  target/WebApp.war  
FROM tomcat 
LABEL name=ashutoshh
COPY --from=STAGE1  /webapp/target/WebApp.war  /usr/local/tomcat/webapps/


EXPOSE 8080 
# just to let docker engine know about default app port  
# CMD bcz default cmd by tomcat image is already set 