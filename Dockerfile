FROM alireza7/s-ui:latest

USER root

# 1. 关键：同时安装 libc6-compat 和 gcompat (解决 Alpine 运行二进制报错问题)
RUN apk add --no-cache curl libc6-compat gcompat

# 2. 下载并安装
RUN curl -L --output /usr/local/bin/cloudflared https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 && \
    chmod +x /usr/local/bin/cloudflared

# 3. 这里的变量名必须与 Northflank 后台填的一致
ENV TUNNEL_TOKEN=""

# 4. 加上 --origincert 排除路径干扰，并在启动时打印版本确认程序存活
CMD ["sh", "-c", "cloudflared --version && s-ui run & sleep 5 && cloudflared tunnel --no-autoupdate run --token ${TUNNEL_TOKEN}"]
