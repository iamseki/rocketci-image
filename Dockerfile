FROM node:12.12.0-alpine

RUN npm -g install @rocket.chat/apps-cli

COPY scripts/app_deploy.sh /usr/local/bin/app_deploy.sh

RUN chmod 755 /usr/local/bin/app_deploy.sh