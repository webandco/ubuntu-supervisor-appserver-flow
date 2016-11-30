#!/bin/bash

set -e
set -u

echo "configure vhosts"
for envname in ${!APPSERVER_VHOST_*}; do
    sed -i "s/{${envname}}/${!envname}/g" /opt/appserver/etc/appserver/conf.d/virtual-hosts.xml
done
