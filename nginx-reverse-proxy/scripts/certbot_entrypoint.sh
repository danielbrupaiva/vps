#!/bin/sh
set -e

if [ -f "/etc/letsencrypt/live/${PUBLIC_HOSTNAME}/fullchain.pem" ]; then
  echo -e "\033[0;36m[certbot]\033[0m Certificate already exists."
  ./scripts/set-nginx-to-domain-config.sh
else
  echo -e "\033[0;31m[certbot]\033[0m Certificate not found. Please run certbot to generate a certificate."
  ./scripts/set-nginx-to-default-config.sh
  ./scripts/get-certificate.sh
  if [ -f "/etc/letsencrypt/live/${PUBLIC_HOSTNAME}/fullchain.pem" ]; then
    echo -e "\033[0;36m[certbot]\033[0m Certificate exists."
    ./scripts/set-nginx-to-domain-config.sh
  else
    echo -e "\033[0;31m[certbot]\033[0m Certificate generation failed. Please check the logs for more details."
    exit 1
  fi
fi



# Loop para renovação automática
#echo "\033[0;36m[certbot]\033[0m Starting certificate renewal loop..."
#while true; do
#  echo "\033[0;36m[certbot]\033[0m Checking certificate renewal..."
#  certbot renew --webroot --webroot-path "$CERTBOT_WEBROOT_PATH" --quiet \
#    --deploy-hook "/nginx-reverse-proxy/scripts/reload-nginx.sh"
#  echo "\033[0;36m[certbot]\033[0m Sleeping for 12 hours..."
#  sleep 12h
#done

## Keep the container running
#tail -f /dev/null
