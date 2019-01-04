FROM node:carbon

LABEL maintainer="florian.thievent@sbb.ch"
LABEL version="0.0.1"
LABEL description="Pieni is a POC of an URL Shortener"

ARG port=3000

ENV SERVER_URL s.bb
ENV SERVER_PORT ${port}
ENV SERVER_EXT 80
ENV REDIS_URL redis
ENV REDIS_PORT 6379

RUN npm install -g concurrently


WORKDIR /app

COPY package.json /app

RUN npm install

COPY . /app

EXPOSE ${port}

CMD concurrently "/usr/bin/redis-server --bind '0.0.0.0'" "sleep 5s; node /app/server.js"