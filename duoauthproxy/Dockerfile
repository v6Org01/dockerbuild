# syntax=docker/dockerfile:1
FROM almalinux:minimal
LABEL os="almalinux"
LABEL maintainer="dev_lau11@a.jlv6.com"
RUN <<EOF
  set -eux
  microdnf update -y
  microdnf install tar wget gcc make libffi-devel perl zlib-devel diffutils -y
  ln -sf /sbin/nologin /bin/nologin
  cd /tmp
  wget -O ./duoauthproxy.tgz --content-disposition https://dl.duosecurity.com/duoauthproxy-latest-src.tgz
  mkdir duoauthproxy
  tar xzf ./duoauthproxy.tgz -C ./duoauthproxy --strip-components=1
  cd ./duoauthproxy
  make
  ./duoauthproxy-build/install --install-dir /opt/duoauthproxy --service-user duo_authproxy_svc --log-group duo_authproxy_grp --enable-selinux=no
  rm -rf ../duoauthproxy ../duoauthproxy.tgz
EOF
EXPOSE 389
ENTRYPOINT ["/opt/duoauthproxy/bin/authproxy"]
