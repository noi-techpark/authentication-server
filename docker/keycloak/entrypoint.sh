#!/bin/bash
set -eou pipefail

echo "set keycloak_private_address=${JGROUPS_PRIVATE_ADDRESS:-127.0.0.1}" >> "$JBOSS_HOME/bin/.jbossclirc"

exec /opt/jboss/tools/docker-entrypoint.sh $@
exit $?
