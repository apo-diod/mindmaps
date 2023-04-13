FROM node:19-alpine3.16 as build

WORKDIR /build

COPY . ./

RUN npm install && npm run build

FROM nginx:1.23.4

COPY --from=build /build/dist /usr/share/nginx/html

EXPOSE 80

RUN sed -i 's/^types {/types {\n    text\/cache-manifest appcache;/' /etc/nginx/mime.types
