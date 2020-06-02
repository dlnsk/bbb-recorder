FROM zenika/alpine-chrome:with-node

ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD 1
ENV PUPPETEER_EXECUTABLE_PATH /usr/bin/chromium-browser

WORKDIR /usr/app

USER root
RUN echo "@edge http://dl-cdn.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories
RUN apk update && apk add xvfb@edge

COPY src/*.json ./src/
COPY src/*.js   ./src/

RUN chown -R chrome:chrome /usr/app

USER chrome
RUN npm install


ENTRYPOINT ["tini", "--"]
#CMD ["node", "src/pdf"]
