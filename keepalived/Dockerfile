FROM alpine:latest
LABEL maintainer="dev_lau11@a.jlv6.com"
LABEL os="alpine"
COPY ./entrypoint.sh /tmp/entrypoint.sh
RUN <<EOF
  chmod o+x /tmp/entrypoint.sh
  apk --update -t add keepalived curl iproute2 grep bash tcpdump sed gettext
  rm -f /var/cache/apk/* /tmp/*
  rm -f /sbin/halt /sbin/poweroff /sbin/reboot
EOF
COPY ./keepalived.conf.env /etc/keepalived/keepalived.conf.env
ENTRYPOINT ["/tmp/entrypoint.sh"]
CMD ["/usr/sbin/keepalived", "--dont-fork", "--log-console", "--log-detail", "--vrrp"]
