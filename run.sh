#!/bin/bash
docker run -it --restart always -p 53:53/tcp -p 53:53/udp --cap-add=NET_ADMIN --name dns-server dns-server:latest
