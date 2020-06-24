FROM node:12.12.0-alpine

WORKDIR /root

RUN npm -g install @rocket.chat/apps-cli

RUN apk add bash 

COPY scripts/run.sh .

COPY scripts/app_deploy.sh /usr/local/bin/app_deploy

RUN chmod +x /usr/local/bin/app_deploy

CMD bash run.sh

