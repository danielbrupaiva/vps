# Stage 1: Build the application
FROM eclipse-temurin:21-jdk-alpine
RUN apk update && apk add --no-cache \
    curl \
    unzip \
    tar \
    certbot \
    openssl \
    curl \
    bash \
    py3-pip \
    ca-certificates
# Set the working directory
WORKDIR /bootoolz
COPY . .
# Make sure the script is executable
RUN chmod +x entrypoint.sh
# Set the script as the entrypoint
ENTRYPOINT ["./entrypoint.sh"]