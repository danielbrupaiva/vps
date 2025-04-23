FROM nginx:alpine
RUN apk update && apk add --no-cache \
    certbot \
    certbot-nginx \
    curl \
    bash 
# Copy the default Nginx configuration
COPY default.conf /etc/nginx/conf.d/default.conf
# Copy the entrypoint script
COPY entrypoint.sh /entrypoint.sh
# Make the script executable
RUN chmod +x /entrypoint.sh
# Set the entrypoint script to run when the container starts
ENTRYPOINT ["/entrypoint.sh"]