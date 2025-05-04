#!/bin/sh
set -e
echo -e "\033[0;32m[nginx]\033[0m Setting nginx to domain config..."
echo -e "\033[0;32m[nginx]\033[0m Substituting env variables in template..."
envsubst '${PUBLIC_HOSTNAME} ${API_NAME} ${API_PORT}' \
    < /etc/nginx/templates/${PUBLIC_HOSTNAME}.template \
    > /etc/nginx/conf.d/${PUBLIC_HOSTNAME}.conf

# Validate Nginx configuration
echo -e "\033[0;32m[nginx]\033[0m Validating configuration..."
nginx -t
if [ $? -eq 0 ]; then
    echo -e "\033[0;32m[nginx]\033[0m config is valid."
  # Reload nginx if it's already running
  if pidof nginx > /dev/null; then
    echo -e "\033[0;32m[nginx]\033[0m Reloading nginx..."
    nginx -s reload
  else
    echo -e "\033[0;32m[nginx]\033[0m Nginx is not running. Starting nginx..."
    nginx -g "daemon off;" &
  fi
else
    echo -e "\033[0;31m[nginx]\033[0m config is invalid!"
    exit 1  
fi