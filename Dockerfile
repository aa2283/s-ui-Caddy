FROM alireza7/s-ui:latest

USER root

# 1. 使用 apk 安装 curl 和 libc 兼容库 (cloudflared 需要)
RUN apk add --no-cache curl libc6-compat

# 2. 下载适合 Alpine (Linux 64-bit) 的 cloudflared 二进制文件
RUN curl -L --output /usr/local/bin/cloudflared https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 && \
    chmod +x /usr/local/bin/cloudflared

# 3. 设置变量 (记得在 Northflank 的 Environment Variables 里填入你的 TOKEN)
ENV TUNNEL_TOKEN=""

# 4. 启动 s-ui 和隧道
# s-ui 默认监听 2095，这里假设你的隧道配置指向 http://localhost:2095
CMD ["sh", "-c", "s-ui run & sleep 2 && cloudflared tunnel --no-autoupdate run --token ${TUNNEL_TOKEN}"]
