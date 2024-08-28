#!/bin/sh

# Substitute environment variables in the configuration template
envsubst < /etc/keepalived/keepalived.conf.env > /etc/keepalived/keepalived.conf

# Execute the main process (default CMD or overridden command)
exec "$@"
