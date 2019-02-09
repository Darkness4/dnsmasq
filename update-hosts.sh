#!/bin/bash
docker exec dns-server sh -c "rm /data/*"
docker cp hosts/. dns-server:/data/
docker exec dns-server sh -c "cat /data/* > /etc/hosts"
echo "Stopping container..."
docker stop dns-server
echo "Done. Restarting..."
echo "Ctrl+P then Ctrl+Q to detach."
docker start dns-server -ai

