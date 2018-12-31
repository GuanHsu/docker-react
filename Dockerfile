# Use an existing docker image as a base for building phase
FROM node:alpine AS builder

WORKDIR /usr/app/web
COPY ./package.json ./
RUN npm install           

COPY ./ ./
# Tell the image what to do when it starts as a container   # Build and run only used in Dev
#CMD ["npm","run", "start"]                                 # Just build for Prod
RUN npm run build

# Use a web server image.  Doc on docker Hub is the basis for using these images
FROM nginx
COPY --from=builder /usr/app/web/build /usr/share/nginx/html

