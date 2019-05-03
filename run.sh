#!/bin/bash
SCRIPT_PATH=`dirname $(realpath $0)`

docker run -d \
    --restart always \
    -p 53:53/tcp \
    -p 53:53/udp \
    -p 67:67/ucp \
	--log-opt max-size=10m \
    --log-opt max-file=5 \
    -v ${SCRIPT_PATH}/hosts:/data \
    -v ${SCRIPT_PATH}/conf/dnsmasq.conf:/etc/dnsmasq.conf \
    --cap-add=NET_ADMIN \
    --name dnsmasq \
    dnsmasq:latest  # darkness4/dnsmasq:latest