# syntax=docker/dockerfile:1
FROM homeassistant/home-assistant:latest
LABEL base_image: "docker.io/homeassistant/home-assistant:latest_stable"
LABEL maintainer="dev_lau11@a.jlv6.com"
# USER root
## LDAP
COPY ./ldap-auth-ad.py /config/ldap-auth/
WORKDIR /config/ldap-auth
RUN <<EOF
  set -eux
  chmod 755 ./ldap-auth-ad.py
  pip install -t . ldap3
EOF
## HACS
WORKDIR /config
RUN <<EOF
  set -eux
  mkdir ./custom_components
  touch ./home-assistant.log
  wget -O - https://get.hacs.xyz | bash -
EOF
EXPOSE 80
ENTRYPOINT ["/init"]
