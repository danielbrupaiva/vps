#!/bin/sh
set -e

if [ -f "/etc/letsencrypt/live/${PUBLIC_HOSTNAME}/fullchain.pem" ]; then
  echo -e "\033[0;36m[certbot]\033[0m Certificate already exists."
  ./scripts/set-nginx-to-domain-config.sh
else
  echo -e "\033[0;36m[certbot]\033[0m Certificate not found. Please run certbot to generate a certificate."
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

# TODO:Loop for automatic renewal
# Keep the container running
tail -f /dev/null