#!/bin/sh
set -e

echo "[certbot] Waiting for nginx to be ready..."
sleep 5

if [ ! -f "/etc/letsencrypt/live/${PUBLIC_HOSTNAME}/fullchain.pem" ]; then
  echo "[certbot] Issuing new certificate for ${PUBLIC_HOSTNAME}..."

  if [ "$APP_PROFILE" = "dev" ]; then
    echo "[certbot] Using staging environment for certificate generation..."
    certbot certonly -v --webroot \
      --webroot-path "$CERTBOT_WEBROOT_PATH" \
      -d "${PUBLIC_HOSTNAME}" -d "www.${PUBLIC_HOSTNAME}" \
      --email "${AUTHOR_EMAIL}" \
      --agree-tos \
      --non-interactive \
      --staging
  else
    certbot certonly -v --webroot \
      --webroot-path "$CERTBOT_WEBROOT_PATH" \
      -d "${PUBLIC_HOSTNAME}" -d "www.${PUBLIC_HOSTNAME}" \
      --email "${AUTHOR_EMAIL}" \
      --agree-tos \
      --non-interactive
  fi

else
  echo "[certbot] Certificate already exists."
fi

echo "[certbot] Reloading nginx in nginx-reverse-proxy container..."
if docker exec nginx-reverse-proxy nginx -s reload; then
  echo "[certbot] Nginx reloaded successfully."
else
  echo "[certbot] ERROR: Failed to reload nginx." >&2
fi

# Loop para renovação automática
echo "[certbot] Starting certificate renewal loop..."
while true; do
  echo "[certbot] Checking certificate renewal..."
  certbot renew --webroot --webroot-path "$CERTBOT_WEBROOT_PATH" --quiet \
    --deploy-hook "/nginx-reverse-proxy/scripts/reload-nginx.sh"
  echo "[certbot] Sleeping for 12 hours..."
  sleep 12h
done
# Keep the container running
#tail -f /dev/null
