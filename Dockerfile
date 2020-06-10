FROM node:alpine AS builder
# the 'builder' tagged phase

WORKDIR '/app'

COPY package.json .
RUN npm install
COPY . .
RUN npm run build
# creates /app/build with all the stuff

FROM nginx
# no tagged phase needed
COPY --from=builder /app/build /usr/share/nginx/html
#Default command for nginx will already run it automatically

