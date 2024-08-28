FROM alpine:latest
LABEL maintainer="dev_lau11@a.jlv6.com"
LABEL os="alpine"
ARG LB
RUN apk --update -t add keepalived curl iproute2 grep bash tcpdump sed && \
    rm -f /var/cache/apk/* /tmp/* && \
    rm -f /sbin/halt /sbin/poweroff /sbin/reboot
COPY ./keepalived.conf.${LB} /etc/keepalived/keepalived.conf
RUN <<EOF
  ln -sf /usr/share/zoneinfo/Europe/Brussels /etc/localtime
EOF
#USER keepalived
ENTRYPOINT ["/usr/sbin/keepalived", "--dont-fork", "--log-console", "--log-detail", "--vrrp"]
