#!/bin/sh
set -e

echo "\033[0;36m[certbot]\033[0m Issuing new certificate for ${PUBLIC_HOSTNAME}..."
if [ "$APP_PROFILE" = "dev" ]; then
echo "\033[0;36m[certbot]\033[0m Using staging environment for certificate generation..."
certbot certonly -v --webroot \
    --webroot-path "/var/www/certbot" \
    -d "${PUBLIC_HOSTNAME}" -d "www.${PUBLIC_HOSTNAME}" \
    --email "${AUTHOR_EMAIL}" \
    --agree-tos \
    --non-interactive \
    --staging
else
echo "\033[0;36m[certbot]\033[0m Using production environment for certificate generation..."
certbot certonly -v --webroot \
    --webroot-path "/var/www/certbot" \
    -d "${PUBLIC_HOSTNAME}" -d "www.${PUBLIC_HOSTNAME}" \
    --email "${AUTHOR_EMAIL}" \
    --agree-tos \
    --non-interactive #\
    #--force-renewal
fi
echo "\033[0;36m[certbot]\033[0m Certificate generation completed."
echo "\033[0;36m[certbot]\033[0m Checking if the certificate was generated successfully..."
if [ -f "/etc/letsencrypt/live/${PUBLIC_HOSTNAME}/fullchain.pem" ]; then
    echo "\033[0;36m[certbot]\033[0m Certificate generated successfully."
else
    echo "\033[0;31m[certbot]\033[0m Certificate generation failed. Please check the logs for more details."
    exit 1
fi