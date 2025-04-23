FROM nginx:alpine
RUN apk update && apk add --no-cache \
    certbot \
    certbot-nginx \
    curl \
    bash 
COPY default.conf /etc/nginx/conf.d/default.conf
RUN certbot --nginx -d bootoolz.com -d www.bootoolz.com