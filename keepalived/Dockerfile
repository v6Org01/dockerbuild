FROM alpine:latest
LABEL maintainer="dev_lau11@a.jlv6.com"
LABEL os="alpine"
RUN <<EOF
  apk --update -t add keepalived curl iproute2 grep bash tcpdump sed gettext
  rm -f /var/cache/apk/* /tmp/*
  rm -f /sbin/halt /sbin/poweroff /sbin/reboot
EOF
COPY ./entrypoint.sh /tmp/entrypoint.sh
COPY ./keepalived.conf.env /etc/keepalived/keepalived.conf.env
RUN chmod o+x /tmp/entrypoint.sh
ENTRYPOINT ["/tmp/entrypoint.sh"]
CMD ["/usr/sbin/keepalived", "--dont-fork", "--log-console", "--log-detail", "--vrrp"]
