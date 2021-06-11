FROM node:8-alpine as build-env

RUN apk --no-cache --virtual build-dependencies add alpine-sdk openssh python gcompat

WORKDIR /wrk

COPY package* ./

RUN npm install

FROM node:8-alpine
WORKDIR /usr/src/app
COPY --from=build-env /wrk/node_modules ./node_modules
ADD . ./

CMD [ "npm", "start" ]
