FROM alpine:latest

ENV TZ=Asia/Shanghai \
    LANG=C.UTF-8

VOLUME /etc/sillyplus

RUN mkdir /usr/local/sillyGirl && cd /usr/local/sillyGirl \
    && wget https://github.com/cdle/sillyGirl/releases/download/main/sillyGirl_linux_amd64 \
    && mv sillyGirl_linux_amd64 sillyGirl && chmod 777 sillyGirl \
    && mkdir /lib64 && ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2 \
    && apk add --no-cache tzdata && cp /usr/share/zoneinfo/$TZ /etc/localtime

ENTRYPOINT ["/usr/local/sillyGirl/sillyGirl"]