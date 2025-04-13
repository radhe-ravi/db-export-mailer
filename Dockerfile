FROM ubuntu:25.05

# Avoid interactive prompts during build
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && \
    apt-get install -y \
    curl \
    zip \
    jq \
    postgresql-client \
    awscli \
    bash && \
    rm -rf /var/lib/apt/lists/*

# Create app directory
WORKDIR /app

# Copy the entire shell project
COPY . .

# Make shell scripts executable
RUN chmod +x run.sh lib/*.sh

# Set entrypoint to your run script
ENTRYPOINT ["./run.sh"]
