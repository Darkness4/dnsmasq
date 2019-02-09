FROM alpine:edge
RUN apk --no-cache add dnsmasq
EXPOSE 53 53/udp

VOLUME /data
ADD hosts /data/

COPY conf/dnsmasq.conf /etc/dnsmasq.conf
COPY conf/resolv.dnsmasq.conf /etc/resolv.dnsmasq.conf

# Bypass Docker DNS Embedded (append hosts AFTER container start)
ENTRYPOINT ["/bin/sh", "-c", "cat /data/* > /etc/hosts && dnsmasq -k --log-facility=-"]

