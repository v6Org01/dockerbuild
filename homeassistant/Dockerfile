# syntax=docker/dockerfile:1
FROM homeassistant/home-assistant:abc
LABEL base_image: "docker.io/homeassistant/home-assistant:latest_stable"
LABEL maintainer="dev_lau11@a.jlv6.com"
USER root
RUN <<EOF
  set -eux
  cd /tmp
EOF
EXPOSE 80
ENTRYPOINT ["/init"]
