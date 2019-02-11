FROM alpine:edge
RUN apk --no-cache add dnsmasq
EXPOSE 53 53/udp

VOLUME /data
ADD hosts /data/

COPY conf/dnsmasq.conf /etc/dnsmasq.conf

# Bypass Docker DNS Embedded (replace hosts AFTER container start)
ENTRYPOINT ["cat /data/* >> /etc/hosts && dnsmasq -k --log-facility=-"]

