FROM node:20-alpine3.19 as base

FROM base as builder

RUN apk add --update --no-cache dumb-init curl
WORKDIR /usr/src/app
COPY ./package.json .
RUN yarn install
COPY . .
RUN yarn build

FROM builder as runtime

ENTRYPOINT ["dumb-init", "--"]

ENV NEXT_TELEMETRY_DISABLED 1
EXPOSE 3000

CMD ["/bin/sh", "-c", "yarn start"]
