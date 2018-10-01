FROM alpine:latest

#ENV CONFIG_JSON=none CERT_PEM=none KEY_PEM=none VER=3.45

#RUN apk add --no-cache --virtual .build-deps ca-certificates curl \
# && mkdir -m 777 /v2raybin \ 
# && cd /v2raybin \
# && curl -L -H "Cache-Con#trol: no-cache" -o v2ray.zip https://d.pcs.baidu.com/file/54d516bd116da9e4f1cfd3cc15e7f167?fid=2099964768-250528-327542799889708&dstime=1538381542&rt=sh&sign=FDtAERVY-DCb740ccc5511e5e8fedcff06b081203-UUwcJhvdg5K8JGSxFfqNMzDO3gA%3D&expires=8h&chkv=1&chkbd=0&chkpc=et&dp-logid=6347302079195234882&dp-callid=0&shareid=4157795171&r=373283057 \
# && unzip v2ray.zip \
# && mv /v2raybin/v2ray-v$VER-linux-64/v2ray /v2raybin/ \
# && mv /v2raybin/v2ray-v$VER-linux-64/v2ctl /v2raybin/ \
# && mv /v2raybin/v2ray-v$VER-linux-64/geoip.dat /v2raybin/ \
# && mv /v2raybin/v2ray-v$VER-linux-64/geosite.dat /v2raybin/ \
# && chmod +x /v2raybin/v2ray \
# && rm -rf v2ray.zip \
# && rm -rf v2ray-v$VER-linux-64 \
# && chgrp -R 0 /v2raybin \
# && chmod -R g+rwX /v2raybin 

RUN mkdir -m 777 /v2ray

ADD entrypoint.sh /entrypoint.sh
ADD config.json /v2ray/config.json
RUN chmod +x /entrypoint.sh 
ENTRYPOINT  /entrypoint.sh 

EXPOSE 8080
