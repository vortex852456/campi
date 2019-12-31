#FROM node:8-buster 
FROM balenalib/rpi-node:8-buster
# FROM node:8-buster-slim
# FROM debian:buster

# ENV DEBIAN_FRONTEND=noninteractive 

WORKDIR /root
RUN apt-get update && \
    apt-get -y install \
    git \
    htop \
    vim nano \
    python build-essential liblivemedia-dev liblog4cpp5-dev cmake libasound2-dev \
    ffmpeg v4l-utils

# MPROMONET RTSP SERVER
# COPY /v4l2rtspserver /var/v4l2rtspserver
WORKDIR /var/v4l2rtspserver
RUN git clone https://github.com/vortex852456/v4l2rtspserver .
RUN cmake .
RUN make
RUN make install

# RPOS
# COPY /rpos /var/rpos
WORKDIR /var/rpos
RUN git clone https://github.com/vortex852456/rpos.git .
RUN npm update
RUN npm install
RUN npm audit fix
RUN npx gulp

RUN mv rposConfig.json rposConfig.default.json
COPY /rposConfig.json /var/rpos/rposConfig.json

EXPOSE 8081
EXPOSE 8554
CMD node rpos.js
