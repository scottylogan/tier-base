FROM   centos:7
MAINTAINER Scotty Logan <swl@stanford.edu>

USER root

RUN yum -y update && \
    yum -y install curl openssl sudo unzip wget \
                   httpd mod_ssl \
                   java-1.7.0-openjdk-headless \
                   tomcat \
                   && \
    yum clean all

EXPOSE 8080
CMD /start.sh
