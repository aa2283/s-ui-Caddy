FROM alireza7/s-ui:latest
USER root

# 安装 cloudflared (基于 Debian 的安装方式)
RUN apt-get update && apt-get install -y curl
RUN curl -L --output cloudflared.deb https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb && \
    dpkg -i cloudflared.deb && \
    rm cloudflared.deb

# 环境变量：方便你在 Northflank 界面随时更换 Token
ENV TUNNEL_TOKEN=""

# 启动 s-ui 和隧道
# 假设你的 s-ui 此时监听在 2095
CMD ["sh", "-c", "s-ui run & cloudflared tunnel --no-autoupdate run --token ${TUNNEL_TOKEN}"]
