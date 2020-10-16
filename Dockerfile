FROM ubuntu:latest

WORKDIR /app

RUN apt-get install nginx -y

COPY . ./

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]