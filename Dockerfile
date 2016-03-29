FROM   centos:7
MAINTAINER Scotty Logan "swl@stanford.edu"

USER root

RUN yum -y update && \
    yum -y install wget unzip && \
    yum clean all

RUN cd /opt

#
# JDK
#
RUN wget --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie;" \
         http://download.oracle.com/otn-pub/java/jdk/8u73-b02/jdk-8u73-linux-x64.tar.gz ; \
    mkdir /usr/local/java ; \
    cd /usr/local/java ; \
    tar -xzf /jdk-8u73-linux-x64.tar.gz ; \ 
    rm /jdk-8u73-linux-x64.tar.gz ; \
    ln -s /usr/local/java/jdk1.8.0_73 /usr/local/java/jdk 

RUN echo 'export PATH="$PATH:/usr/local/java/jdk/bin"' > /etc/profile.d/java.sh ; \
    echo 'export JAVA_HOME=/usr/local/java/jdk' >> /etc/profile.d/java.sh

#
# Java Cryptography Extension (JCE) Unlimited Strength Jurisdiction Policy Files 8 Download
#
RUN wget --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie;" \
         http://download.oracle.com/otn-pub/java/jce/8/jce_policy-8.zip
RUN cd /usr/local/java/jdk/jre/lib/security ; \
    mv /jce_policy-8.zip /usr/local/java/jdk/jre/lib/security ; \
    unzip jce_policy-8.zip ; \
    mv UnlimitedJCEPolicyJDK8/* ./ ; \
    rmdir UnlimitedJCEPolicyJDK8 ; \
    rm jce_policy-8.zip 
     
#
# Jetty
#
RUN wget http://download.eclipse.org/jetty/stable-9/dist/jetty-distribution-9.3.8.v20160314.tar.gz
RUN tar -xvzf jetty-distribution-9.3.8.v20160314.tar.gz -C /opt/ ; \
    mv /opt/jetty-distribution-9.3.8.v20160314 /opt/jetty ; \
    useradd -m jetty ; \
    chown -R jetty:jetty /opt/jetty/ 
RUN echo 'JAVA=/usr/local/java/jdk/bin/java' > /etc/default/jetty ; \
    echo 'JETTY_HOME=/opt/jetty' >> /etc/default/jetty ; \
    echo 'JETTY_USER=jetty' >> /etc/default/jetty ; \
    echo 'JETTY_PORT=8080' >> /etc/default/jetty ; \
    echo 'JETTY_LOGS=/opt/jetty/logs/' >> /etc/default/jetty
 

# 
# testing only
#
#RUN yum -y install httpd; \ 
#    yum clean all; \
#    systemctl enable httpd.service
#EXPOSE 80

