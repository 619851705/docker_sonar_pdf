#!/bin/sh

set -e

if [ "${1:0:1}" != '-' ]; then
  exec "$@"
fi

chown -R sonarqube:sonarqube $SONARQUBE_HOME
exec su-exec sonarqube \
  java -jar lib/sonar-application-$SONARQUBE_VERSION.jar \
  -Dsonar.log.console=true \
  "$@"
