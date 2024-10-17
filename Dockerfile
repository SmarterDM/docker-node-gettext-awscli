FROM node:18.20.4

RUN apt-get update
RUN apt-get -y install python3-pip gettext ca-certificates curl gnupg lsb-release groff less
RUN mkdir -p /etc/apt/keyrings
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
RUN echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
      $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
RUN apt-get update
RUN apt-cache policy docker-ce

# Remove unnecessary Python installations if not needed elsewhere
# RUN apt-get install -y python3 python3-pip

# Install docker-ce and docker-ce-cli
RUN apt-get update && apt-get install -y docker-ce docker-ce-cli

# Install Docker Compose plugin
RUN apt-get install -y docker-compose-plugin

# Install dependencies for AWS CLI
RUN apt-get install -y curl unzip

# Install AWS CLI v2
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
RUN unzip awscliv2.zip
RUN ./aws/install

# Clean up installation files
RUN rm -rf awscliv2.zip aws
