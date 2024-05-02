# build stage
FROM node:lts-alpine as build-stage
WORKDIR /app

RUN apk update && apk add git

ARG env=prod
ENV VITE_API_URL=$env

RUN echo "Building with ${VITE_API_URL}"

COPY package.json ./
COPY yarn.lock ./
RUN yarn install
COPY . .
RUN yarn build

# production stage
FROM nginx:stable-alpine as production-stage
COPY --from=build-stage /app/dist /usr/share/nginx/html
COPY --from=build-stage /app/nginx.conf /etc/nginx/nginx.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
