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

# Optional: Add Certbot auto-renewal
# Cron job or systemd timer could be set here if needed
# (This can also be set inside the container if running as a long-lived service)