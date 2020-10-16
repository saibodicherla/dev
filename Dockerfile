# Pull base image from Dockerhub.
FROM ubuntu:latest

#Install Ngnix
RUN \
  add-apt-repository -y ppa:nginx/stable && \
  apt-get update && \
  apt-get install -y nginx && \
  rm -rf /var/lib/apt/lists/* && \
  echo "\ndaemon off;" >> /etc/nginx/nginx.conf && \
  chown -R www-data:www-data /var/lib/nginx

#Define Working directory 
WORKDIR /etc/nginx

# Expose ports
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]