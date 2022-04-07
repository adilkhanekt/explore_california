FROM nginx:alpine
MAINTAINER Adilkhan <adilkhanekt@gmail.com>

COPY website /website
COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 80