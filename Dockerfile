FROM node:19-alpine3.16 as build

WORKDIR /build

COPY . ./

RUN npm install && npm run build

FROM nginx:1.23.4

COPY --from=build /build/dist /usr/share/nginx/html

EXPOSE 80

RUN sed '$d' /etc/ngninx/mime.types && printf "\ttext/cache-manifest\tappcache;\n}"
