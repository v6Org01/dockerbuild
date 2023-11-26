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
  mkdir -p ./custom_components/hacs
  wget "https://github.com/hacs/integration/releases/latest/download/hacs.zip"
  unzip ./hacs.zip -d ./custom_components/hacs
  rm -rf ./hacs.zip
EOF
EXPOSE 80
ENTRYPOINT ["/init"]
