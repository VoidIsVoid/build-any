FROM d.hii.us.kg/ubuntu:22.04

COPY install.sh /install.sh

WORKDIR /app
RUN bash /install.sh