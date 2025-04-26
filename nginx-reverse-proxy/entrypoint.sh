#!/bin/sh
set -e

# Export all environment variables into nginx config
echo "[nginx] Substituting env variables in template..."
envsubst '${PUBLIC_HOSTNAME} ${API_NAME} ${API_PORT}' \
  < /etc/nginx/templates/default.conf.template \
  > /etc/nginx/conf.d/default.conf

# Validate Nginx configuration
echo "[nginx] Validating configuration..."
nginx -t

# Start nginx in the foreground
echo "[nginx] Starting nginx in the foreground..."
exec nginx -g "daemon off;"