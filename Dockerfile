FROM node:16.19.0

RUN apt-get update
RUN apt-get -y install python3-pip gettext ca-certificates curl gnupg lsb-release groff less
RUN mkdir -p /etc/apt/keyrings
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
RUN echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
      $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
RUN apt-get update
RUN apt-cache policy docker-ce
RUN apt-get -y install docker-ce docker-ce-cli
RUN pip3 install docker-compose==1.28.6 awscli
