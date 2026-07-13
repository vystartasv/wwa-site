#!/usr/bin/env bash
# Deploy wwa-site to VPS
set -e

VPS_HOST="root@178.105.85.197"
REMOTE_DIR="/opt/wwa-site"

echo "═══ Deploying wwa-site ═══"

# Rsync all files
rsync -avz --delete \
  --exclude=.git \
  --exclude=.gitignore \
  --exclude=deploy.sh \
  --exclude=README.md \
  "$(dirname "$0")/" \
  "$VPS_HOST:$REMOTE_DIR/"

# Fix permissions
ssh "$VPS_HOST" "find $REMOTE_DIR -type f -exec chmod 644 {} + && find $REMOTE_DIR -type d -exec chmod 755 {} +"

# Copy nginx config
scp "$(dirname "$0")/wwa-site.nginx.conf" "$VPS_HOST:/etc/nginx/sites-enabled/wwa-site.conf"
ssh "$VPS_HOST" "nginx -t && systemctl reload nginx"

echo "═══ Done ═══"
echo "Verify: curl -s -H 'Host: workswithagents.com' http://178.105.85.197/ | grep 'Win more UK tenders'"
