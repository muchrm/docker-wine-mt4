FROM debian:stretch-slim
WORKDIR /root/mt4
COPY mt4 .
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    x11vnc \
    xorg \
    xvfb \
    openbox \
    menu

RUN dpkg --add-architecture i386 \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
    wine \
    wine32 \
    libwine \
    fonts-wine

ENV DISPLAY=:1
ARG VNC_PASSWORD=secret

ENV VNC_PASSWORD ${VNC_PASSWORD}

CMD Xvfb :1 -screen 0 1024x768x16 \
    & openbox-session \
    & x11vnc -display :1 -xkb -forever -passwd $VNC_PASSWORD
EXPOSE 5900
