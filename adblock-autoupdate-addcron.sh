#!/bin/sh
cp adblock-updater.sh /adblock-updater.sh
(crontab -l 2>/dev/null; echo "0 5 * * * sh /adblock-updater.sh $(pwd)/hosts/adblock.hosts && docker restart dns >/dev/null 2>&1") | crontab -