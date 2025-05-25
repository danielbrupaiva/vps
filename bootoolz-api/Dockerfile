# -------- Stage 1: Build the application --------
FROM gradle:8.10.0-jdk21 AS builder
# Set working directory
WORKDIR /app
# Copy only files needed to resolve dependencies
COPY . .
# Pre-download dependencies (cache layer)
RUN gradle build -x test --no-daemon || return 0
# Copy the rest of the project
COPY . .
# Build the JAR (skip tests for speed)
RUN gradle bootJar -x test --no-daemon

# -------- Stage 2: Create a minimal runtime image --------
FROM eclipse-temurin:21-jre

# Create a non-root user
RUN useradd -ms /bin/bash spring

WORKDIR /home/spring

# Copy only the generated JAR from builder
COPY --from=builder /app/build/libs/*.jar app.jar

# Use non-root user
USER spring

# Run the Spring Boot app
ENTRYPOINT ["java", "-jar", "app.jar"]
