FROM alpine:latest

ENV CONFIG_JSON={
  "log": {
    "loglevel": "warning"
  },
  "inbound": {
    "protocol": "vmess",
    "port": 8080,
    "settings": {
      "clients": [
        {
          "id": "5c3d651f-7dda-49b2-8742-0a8b2c8fae3d",
          "alterId": 64
        }
      ]
    },
    "streamSettings": {
      "network": "ws"
    }
  },
  "outbound": {
    "protocol": "freedom",
    "settings": {}
  }
} CERT_PEM=none KEY_PEM=none VER=4.31.0

RUN apk add --no-cache --virtual .build-deps ca-certificates curl \
 && mkdir -m 777 /v2raybin \ 
 && cd /v2raybin \
 && curl -L -H "Cache-Con#trol: no-cache" -o v2ray.zip https://github.com/v2ray/v2ray-core/releases/download/v$VER/v2ray-linux-64.zip \
 && unzip v2ray.zip \
 && mv /v2raybin/v2ray-v$VER-linux-64/v2ray /v2raybin/ \
 && mv /v2raybin/v2ray-v$VER-linux-64/v2ctl /v2raybin/ \
 && mv /v2raybin/v2ray-v$VER-linux-64/geoip.dat /v2raybin/ \
 && mv /v2raybin/v2ray-v$VER-linux-64/geosite.dat /v2raybin/ \
 && chmod +x /v2raybin/v2ray \
 && rm -rf v2ray.zip \
 && rm -rf v2ray-v$VER-linux-64 \
 && chgrp -R 0 /v2raybin \
 && chmod -R g+rwX /v2raybin 

RUN mkdir -m 777 /v2ray

ADD entrypoint.sh /entrypoint.sh
ADD config.json /v2ray/config.json
RUN chmod +x /entrypoint.sh 
ENTRYPOINT  /entrypoint.sh 

EXPOSE 8080
