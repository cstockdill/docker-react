FROM node:alpine
# the 'builder' tagged phase (later removed for AWS deploy)

WORKDIR '/app'

COPY package.json .
RUN npm install
COPY . .
RUN npm run build
# creates /app/build with all the stuff

FROM nginx
# Expose is needed for the Elastic Beanstalk deploy for mapping and exposing
EXPOSE 80
# no tagged phase needed
COPY --from=0 /app/build /usr/share/nginx/html
#Default command for nginx will already run it automatically

