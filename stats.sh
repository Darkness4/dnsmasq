#!/bin/sh
docker logs dns 2>&1 | tr -d '\r' | awk -f dnsmasq_parser.awk | less