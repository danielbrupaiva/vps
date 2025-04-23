#!/bin/bash

# Ensure Nginx is not running at the start
nginx -s stop

# Obtain SSL certificates using Certbot
certbot --nginx -d bootoolz.com -d www.bootoolz.com \
  --agree-tos \
  --redirect \
  --hsts \
  --staple-ocsp \
  --email danielbrug@gmail.com \
  --non-interactive \
  --staging

# Start Nginx with the SSL certificates
nginx -g 'daemon off;'

# Optional: Set up Certbot auto-renewal using a cron job
echo "Setting up Certbot auto-renewal with cron job..."

# Create a cron job for Certbot auto-renewal
echo "0 0,12 * * * root certbot renew --quiet && systemctl reload nginx" > /etc/cron.d/certbot-renewal

# Make sure the cron job is executable
chmod +x /etc/cron.d/certbot-renewal

# Start cron daemon (needed to run cron jobs)
cron