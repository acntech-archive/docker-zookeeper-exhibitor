#!/bin/bash

if [ "x$JAVA_HOME" = "x" ]; then
   echo "JAVA_HOME is not set"
   exit 1
fi

if [ "x$EXHIBITOR_HOME" = "x" ]; then
   echo "EXHIBITOR_HOME is not set"
   exit 1
fi

if [ "x$EXHIBITOR_DATA" = "x" ]; then
   echo "EXHIBITOR_DATA is not set"
   exit 1
fi

if [ "x$EXHIBITOR_LOGS" = "x" ]; then
   echo "EXHIBITOR_LOGS is not set"
   exit 1
fi

_EXHIBITOR_LOG="${EXHIBITOR_LOGS}/exhibitor.log"
_EXHIBITOR_JAR="${EXHIBITOR_HOME}/exhibitor.jar"

_EXHIBITOR_CMD="${JAVA_HOME}/bin/java -jar ${_EXHIBITOR_JAR} -c file --fsconfigdir ${EXHIBITOR_DATA}"

case $1 in
start)
   nohup ${_EXHIBITOR_CMD} > ${_EXHIBITOR_LOG} 2>&1 < /dev/null &
   ;;
start-foreground)
   ${_EXHIBITOR_CMD}
   ;;
*)
   echo "Usage: $0 {start|start-foreground}" >&2
esac