#!/bin/sh
JAVA_OPTS="-Xms256m -Xmx2048m"
export JAVA_OPTS
/tomcat7/bin/catalina.sh run
