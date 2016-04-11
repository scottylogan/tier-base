# Native Docker Container

This branch contains a more native CentOS 7 container for TIER apps.
Instead of using Oracle's Java and Jetty, it uses OpenJDK and Tomcat,
which are already part of the CentOS 7 distribution. While the
developers seem to prefer non-stock Java and Tomcat, it's much better
operationally to use the ones provided by the distribution.
