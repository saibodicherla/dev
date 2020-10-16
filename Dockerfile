# Pull base image from Dockerhub.
FROM ubuntu:18.04

#Install Ngnix
RUN apt-get update && apt-get install -y --no-install-recommends \
    nginx=1.17.0-0ubuntu0.18.04 \
    && rm -rf /var/lib/apt/lists/* 

RUN printf "\ndaemon off;" >> /etc/nginx/nginx.conf \
    && chown -R www-data:www-data /var/lib/nginx

#Define Working directory 
WORKDIR /etc/nginx

# Expose ports
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]