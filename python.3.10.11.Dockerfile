# 指定基础镜像
FROM python:3.10.11

# 升级 pip
RUN pip config set global.index-url  http://mirrors.aliyun.com/pypi/simple/ \
&& python -m pip install --upgrade pip

# 安装 SSH 服务
RUN apt-get update && apt-get install -y openssh-server

# 设置 SSH 登录密码
RUN echo 'root:1' | chpasswd

# 修改 SSH 配置，允许密码登录并开放 22 端口
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/#PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config && \
    echo "Port 22" >> /etc/ssh/sshd_config

RUN mkdir -p /run/sshd

EXPOSE 22

# 启动 SSH 服务
CMD ["/usr/sbin/sshd", "-D"]
