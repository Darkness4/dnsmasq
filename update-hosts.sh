#!/bin/bash
docker exec dnsmasq sh -c "rm /data/*"
docker cp hosts/. dnsmasq:/data/
docker exec dnsmasq sh -c "cat /data/* > /etc/hosts"
echo "Stopping container..."
docker stop dnsmasq
echo "Done. Restarting..."
echo "Ctrl+P then Ctrl+Q to detach."
docker start dnsmasq -ai

