#!/bin/bash
set -e

echo "[certbot] Certificate renewed! Reloading nginx in external container..."

docker exec nginx-reverse-proxy nginx -s reload

echo "[certbot] Nginx reloaded successfully."
