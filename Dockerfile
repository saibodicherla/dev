# Pull base image from Dockerhub.
FROM ubuntu:18.04

#Install Ngnix
RUN apt-get update && apt-get install -y --no-install-recommends \
    && nginx  \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* 

RUN echo "daemon off;" >> /etc/nginx/nginx.conf 

#Define Working directory 
WORKDIR /etc/nginx

# Expose ports
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]