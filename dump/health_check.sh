#!/bin/sh

set -e

APPNET_AGENT_ADMIN_MODE=${APPNET_AGENT_ADMIN_MODE:-tcp}
APPNET_AGENT_HTTP_ADDRESS=${APPNET_AGENT_HTTP_BIND_ADDRESS:-127.0.0.1}
APPNET_AGENT_HTTP_PORT=${APPNET_AGENT_HTTP_PORT:-9902}
APPNET_AGENT_ADMIN_UDS_PATH=${APPNET_AGENT_ADMIN_UDS_PATH:-/var/run/ecs/appnet_admin.sock}
if [ $APPNET_AGENT_ADMIN_MODE = "tcp" ]; then
  curl "http://${APPNET_AGENT_HTTP_ADDRESS}:${APPNET_AGENT_HTTP_PORT}/status" | grep healthStatus | grep -w HEALTHY
else
  curl --unix-socket ${APPNET_AGENT_ADMIN_UDS_PATH} "http://localhost/status" | grep healthStatus | grep -w HEALTHY
fi
