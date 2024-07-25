FROM d.hii.us.kg/ubuntu:22.04

WORKDIR /app
COPY install.sh ./
RUN bash install.sh