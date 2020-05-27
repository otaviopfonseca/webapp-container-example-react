# build environment
FROM node:12.16-slim as node
WORKDIR /app
COPY package.json /app/
RUN npm i npm@latest -g
RUN npm install
COPY ./ /app/
RUN npm run build

# production environment
FROM nginx:stable-alpine
COPY --from=node /app/build /usr/share/nginx/html
# new
COPY ./nginx-custom.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]