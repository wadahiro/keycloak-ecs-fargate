#!/bin/sh

# Debug
ip -f inet -o addr show

# Find private ip address
export EXTERNAL_ADDR=`ip -f inet -o addr show eth1 | cut -d" " -f 7 | cut -d/ -f 1`

if [ "$EXTERNAL_ADDR" = "" ]; then
    EXTERNAL_ADDR=127.0.0.1
fi

echo "Use $EXTERNAL_ADDR for clustering."

sh /opt/jboss/docker-entrypoint.sh $@ -Djgroups.bind_addr=$EXTERNAL_ADDR

