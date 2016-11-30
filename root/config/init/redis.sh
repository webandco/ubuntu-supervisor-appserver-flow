#!/bin/bash

set -e
set -u

if [ "${APPSERVER_OVERRIDE_REDIS_CONF}" = TRUE ]; then
    echo "configure redis"
    sed -i "s/\;extension/extension/g" /opt/appserver/etc/conf.d/redis.ini
fi
