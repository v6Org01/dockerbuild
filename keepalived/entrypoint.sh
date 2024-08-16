#!/bin/sh

# Function to check if HAProxy is ready
check_haproxy() {
  while ! /usr/bin/curl -sf http://127.0.0.1:8404/healthz; do
    echo "Waiting for HAProxy to be ready..."
    sleep 5
  done
}

# Run the check_haproxy function
check_haproxy

# Replace the shell with the keepalived process
exec /usr/sbin/keepalived --dont-fork --log-console --log-detail --vrrp
