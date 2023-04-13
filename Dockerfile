FROM node:18.12.1 as build

WORKDIR /build

COPY . ./

RUN npm install && npm run build

FROM nginx:1.22.1

COPY --from=build /build/dist /usr/share/nginx/html

# Add cache manifest to mime.types as per documentaion
RUN sed -i '$d' /etc/nginx/mime.types && printf "\ttext/cache-manifest\tappcache;\n}" >> /etc/nginx/mime.types
