FROM ubuntu:oracular-20240811.1

RUN apt-get update && \
    apt-get install -y openssl nginx

RUN mkdir -p /etc/nginx/certificate

WORKDIR /etc/nginx/certificate

RUN openssl req -new -newkey rsa:4096 -x509 -sha256 -days 365 -nodes -out nginx-certificate.crt -keyout nginx.key \
    -subj "/C=US/ST=State/L=City/O=Organization/OU=Department/CN=example.com"

COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]
