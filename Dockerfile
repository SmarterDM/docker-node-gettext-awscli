FROM node:20.19.1

# Install pnpm globally
RUN npm install -g pnpm

# Install necessary packages and dependencies
RUN apt-get update && apt-get install -y \
    python3-pip \
    gettext \
    ca-certificates \
    curl \
    gnupg \
    lsb-release \
    groff \
    less \
    unzip

# Set up Docker's official GPG key and repository
RUN mkdir -p /etc/apt/keyrings \
    && curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg \
    && echo \
       "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
       $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker Engine, CLI, and Compose plugin
RUN apt-get update && apt-get install -y \
    docker-ce \
    docker-ce-cli \
    docker-compose-plugin

# Install AWS CLI v2
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip \
    && ./aws/install

# Clean up installation files and apt cache
RUN rm -rf awscliv2.zip aws \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
