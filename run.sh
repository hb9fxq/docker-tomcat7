#!/bin/sh
export JAVA_OPTS="-Xmx1G -XX:MaxPermSize=384m"
/tomcat7/bin/catalina.sh run
