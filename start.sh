#! /bin/bash

( 

  [ -f /etc/tomcat/tomcat.conf ] && . /etc/tomcat/tomcat.conf;
  [ -f /etc/sysconfig/tomcat ] && . /etc/sysconfig/tomcat;
  /usr/libexec/tomcat/server start;
  kill 1
) &

[ -f /etc/sysconfig/httpd ] && . /etc/sysconfig/httpd

exec /usr/sbin/httpd $OPTIONS -DFOREGROUND

