#!/bin/sh
set -e

echo -e "\033[0;36m[certbot]\033[0m Issuing certificate for ${PUBLIC_HOSTNAME} and subdomains..."

DOMAINS="-d ${PUBLIC_HOSTNAME} -d www.${PUBLIC_HOSTNAME} -d api.${PUBLIC_HOSTNAME} -d mongo-express.${PUBLIC_HOSTNAME}"

if [ "$APP_PROFILE" = "dev" ]; then
    echo -e "\033[0;36m[certbot]\033[0m Using staging environment..."
    certbot certonly -v --webroot \
        --webroot-path "/var/www/certbot" \
        $DOMAINS \
        --email "${AUTHOR_EMAIL}" \
        --agree-tos \
        --non-interactive \
        --staging
else
    echo -e "\033[0;36m[certbot]\033[0m Using production environment..."
    certbot certonly -v --webroot \
        --webroot-path "/var/www/certbot" \
        $DOMAINS \
        --email "${AUTHOR_EMAIL}" \
        --agree-tos \
        --non-interactive
        # --force-renewal  # Uncomment if needed
fi

echo -e "\033[0;36m[certbot]\033[0m Certificate generation completed."
echo -e "\033[0;36m[certbot]\033[0m Verifying certificate presence..."

CERT_PATH="/etc/letsencrypt/live/${PUBLIC_HOSTNAME}/fullchain.pem"
if [ -f "$CERT_PATH" ]; then
    echo -e "\033[0;32m[certbot]\033[0m Certificate successfully created at $CERT_PATH"
else
    echo -e "\033[0;31m[certbot]\033[0m Certificate generation failed. Check logs."
    exit 1
fi
