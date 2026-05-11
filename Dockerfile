# 修正后的正确镜像名
FROM alireza7/s-ui:latest

USER root

# 1. 安装 Caddy (Alpine 环境)
RUN apk add --no-cache caddy

# 2. 复制你的 Caddyfile
COPY Caddyfile /etc/caddy/Caddyfile

# 3. 告知平台端口
EXPOSE 2095

# 4. 启动逻辑：
# 先以后台模式启动 s-ui
# 再以前台模式启动 Caddy（这样容器会一直保持运行）
CMD ["sh", "-c", "/app/s-ui & caddy run --config /etc/caddy/Caddyfile --adapter caddyfile"]
