# 指定基础镜像
FROM python:3.10.11
ENV TZ=Asia/Shanghai
ENV HF_ENDPOINT=https://hf-mirror.com

# Use Aliyun mirror for apt sources
RUN pip config set global.index-url  http://mirrors.aliyun.com/pypi/simple/ && \
    python -m pip install --upgrade pip && \
    mv /etc/apt/sources.list /etc/apt/sources.list.bak && \
    echo "deb http://mirrors.aliyun.com/debian/ bullseye main contrib non-free" > /etc/apt/sources.list && \
    echo "deb http://mirrors.aliyun.com/debian/ bullseye-updates main contrib non-free" >> /etc/apt/sources.list && \
    echo "deb http://mirrors.aliyun.com/debian/ bullseye-backports main contrib non-free" >> /etc/apt/sources.list && \
    echo "deb http://mirrors.aliyun.com/debian-security bullseye-security main contrib non-free" >> /etc/apt/sources.list && \
    apt-get update && apt-get install -y \
        openssh-server \
        tmux \
        nethogs \
        htop \
        vim && \
    rm -rf /var/lib/apt/lists/* && \
    echo 'alias ll="ls -al"' >> ~/.bashrc && \
    echo 'export HF_ENDPOINT=https://hf-mirror.com' >> ~/.bashrc && \
    echo 'root:1' | chpasswd && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/#PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config && \
    echo "Port 22" >> /etc/ssh/sshd_config && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo '$TZ' > /etc/timezong

RUN mkdir -p /run/sshd

EXPOSE 22

# 启动 SSH 服务
CMD ["/usr/sbin/sshd", "-D"]
