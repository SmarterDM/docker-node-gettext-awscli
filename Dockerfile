FROM node:14

RUN apt-get update
RUN apt-get -y install python3-pip gettext
RUN pip3 install awscli

CMD [ "node", "server.js" ]
