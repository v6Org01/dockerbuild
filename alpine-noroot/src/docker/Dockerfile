ARG REGISTRY=docker.io
ARG DEFAULT_UID
ARG DEFAULT_USER
ARG DEFAULT_GID
ARG DEFAULT_GROUP
FROM ${REGISTRY}/alpine:latest
LABEL maintainer="dev_lau11@a.jlv6.com"
LABEL os="alpine"
RUN <<EOF
  apk add --no-cache shadow
  rm -f /var/cache/apk/* /tmp/*
  addgroup --system --gid ${DEFAULT_GID} ${DEFAULT_GROUP}
  adduser --system --disabled-password --home /home/${DEFAULT_USER} --uid ${DEFAULT_UID} --ingroup ${DEFAULT_GROUP} ${DEFAULT_USER}
EOF
USER ${DEFAULT_USER}
ENTRYPOINT ["/bin/sh"]
