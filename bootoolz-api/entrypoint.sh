#!/bin/bash
set -e

echo "Starting Spring Boot app..."

if [ "$APP_PROFILE" == "prod" ]; then
    echo "Running in production mode..."
    exec ./gradlew bootRun --args='--spring.profiles.active=prod'
else
    echo "Running in development mode..."
    exec ./gradlew bootRun --args='--spring.profiles.active=dev'
fi