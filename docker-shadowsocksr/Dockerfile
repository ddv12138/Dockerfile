FROM ubuntu

ENV SSR_URL https://github.com/shadowsocksr-backup/shadowsocksr.git
ENV SS_PORT 1234
ENV SS_PASSWD your-password-here
ENV SS_METH aes-256-cfb #encryption method
ENV SS_OBFS http_simple #obfsplugin

RUN set -ex \
    && apt update \
    && apt install -y  python-pip python-dev build-essential git \
    && pip install --upgrade pip \
    && git clone ${SSR_URL} 
WORKDIR /shadowsocksr/shadowsocks

CMD python server.py -p $SS_PORT -k $SS_PASSWD -m $SS_METH -o $SS_OBFS --fast-open
