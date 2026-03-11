#!/bin/sh
set -e

# Injicera miljövariabler i config.js
envsubst < /etc/nginx/config.js.template > /usr/share/nginx/html/config.js

echo "config.js genererad (GROCY_URL=${GROCY_URL})"

# Starta nginx
exec nginx -g "daemon off;"
