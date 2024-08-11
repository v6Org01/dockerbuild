# syntax=docker/dockerfile:1
FROM lldap/lldap:2024-07-20-alpine-rootless
LABEL os="alpine"
LABEL maintainer="dev_lau11@a.jlv6.com"
USER root
RUN <<EOF
  apk --update -t add --no-cache curl jq jo
  apk upgrade --no-cache
  rm -f /var/cache/apk/* /tmp/*
EOF
USER lldap
