FROM alireza7/s-ui:latest

USER root

# 1. 关键：同时安装 libc6-compat 和 gcompat (解决 Alpine 运行二进制报错问题)
RUN apk add --no-cache curl libc6-compat gcompat

# 2. 下载并安装
RUN curl -L --output /usr/local/bin/cloudflared https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 && \
    chmod +x /usr/local/bin/cloudflared

# 3. 这里的变量名必须与 Northflank 后台填的一致
ENV TUNNEL_TOKEN=""

# 增加权限检查和显式日志输出
# 显式指定路径，并使用 nohup 确保进程互不干扰
CMD ["sh", "-c", "s-ui run > /dev/null 2>&1 & sleep 3 && /usr/local/bin/cloudflared tunnel --no-autoupdate run --token ${TUNNEL_TOKEN} 2>&1"]
