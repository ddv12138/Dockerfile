# 指定基础镜像
FROM python:3.10.11
ENV TZ=Asia/Shanghai
ENV HF_ENDPOINT=https://hf-mirror.com

# Use Aliyun mirror for apt sources
RUN pip config set global.index-url http://mirrors.aliyun.com/pypi/simple/ && \
    pip config set global.trusted-host mirrors.aliyun.com && \
    python -m pip install --upgrade pip && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo '$TZ' > /etc/timezong && \
    pip install aktools

RUN mkdir -p /run/sshd

EXPOSE 8080

CMD ["python", "-m","aktools","--host","0.0.0.0"]
