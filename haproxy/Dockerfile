FROM alpine:3.19.1
LABEL maintainer="dev_lau11@a.jlv6.com"
LABEL os="alpine3.19.1"
RUN apk --update -t add --no-cache haproxy curl iproute2 && \
    rm -f /var/cache/apk/* /tmp/* && \
    rm -f /sbin/halt /sbin/poweroff /sbin/reboot
COPY ./haproxy.cfg /usr/local/etc/haproxy/haproxy.cfg
RUN <<EOF
  addgroup -S haproxy && adduser -S -G haproxy haproxy
  chown haproxy:haproxy /usr/local/etc/haproxy/haproxy.cfg
  chmod 644 /usr/local/etc/haproxy/haproxy.cfg
EOF
USER haproxy
# Start HAProxy (-db = do not background)
CMD ["haproxy", "-f", "/usr/local/etc/haproxy/haproxy.cfg", "-db"]
