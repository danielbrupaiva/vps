# Stage 1: Build the application
FROM eclipse-temurin:21-jdk-jammy
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    unzip \
    tar \
    bash && \
    rm -rf /var/lib/apt/lists/*
# Set the working directory
WORKDIR /bootoolz
COPY . .
# Make sure the script is executable
RUN chmod +x entrypoint.sh
# Set the script as the entrypoint
ENTRYPOINT ["./entrypoint.sh"]