FROM alpine:3.19.1
LABEL maintainer="dev_lau11@a.jlv6.com"
LABEL os="alpine3.19.1"
ARG LB
RUN apk --update -t add keepalived iproute2 grep bash tcpdump sed && \
    rm -f /var/cache/apk/* /tmp/* && \
    rm -f /sbin/halt /sbin/poweroff /sbin/reboot
COPY ./keepalived.conf.${LB} /etc/keepalived/keepalived.conf
RUN <<EOF
  addgroup -S keepalived && adduser -S -G keepalived keepalived
  chown -R keepalived:keepalived /etc/keepalived
  chmod 644 /etc/keepalived/keepalived.conf
  setcap cap_net_admin,cap_net_raw,cap_net_broadcast+ep /usr/sbin/keepalived
  ln -sf /usr/share/zoneinfo/Europe/Brussels /etc/localtime
EOF
USER keepalived
ENTRYPOINT ["/usr/sbin/keepalived", "--dont-fork", "--dump-conf", "--log-console", "--log-detail", "--vrrp"]
