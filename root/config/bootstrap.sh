#!/bin/bash

set -e
set -u

echo "bootstraping environment..."
mkdir -p /data/conf /data/run /data/logs
chmod 711 /data/conf /data/run /data/logs

if [ "$(ls /config/init/)" ]; then
  for init in /config/init/*.sh; do
    . $init
  done
fi

if [ "${APPSERVER_OVERRIDE_APPSERVER_CONF}" = TRUE ]; then
    echo "configure appserver"
    cp /etc/appserver/appserver.xml /opt/appserver/etc/appserver/appserver.xml
    for envname in ${!APPSERVER_CONFIG_*}; do
        sed -i "s/{${envname}}/${!envname}/g" /opt/appserver/etc/appserver/appserver.xml
    done
fi

if [ "${APPSERVER_OVERRIDE_VHOST_CONF}" = TRUE ]; then
    echo "configure vhosts"
    cp /etc/appserver/virtual-hosts.xml /opt/appserver/etc/appserver/conf.d/virtual-hosts.xml
    for envname in ${!APPSERVER_VHOST_*}; do
        sed -i "s/{${envname}}/${!envname}/g" /opt/appserver/etc/appserver/conf.d/virtual-hosts.xml
    done
fi

if [ "${APPSERVER_OVERRIDE_REDIS_CONF}" = TRUE ]; then
    echo "configure redis"
    cp /etc/appserver/redis.ini /opt/appserver/etc/conf.d/redis.ini
    for envname in ${!APPSERVER_REDIS_*}; do
        sed -i "s/{${envname}}/${!envname}/g" /opt/appserver/etc/conf.d/redis.ini
    done
fi

echo "start supervisor"
/usr/bin/supervisord
