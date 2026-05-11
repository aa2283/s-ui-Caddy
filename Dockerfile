# 假设你用的是这个 s-ui 镜像，如果不是请替换
FROM alireza0/s-ui:latest

USER root
# 安装 Caddy
RUN apk add --no-cache caddy

# 复制配置文件
COPY Caddyfile /etc/caddy/Caddyfile

# 同时启动 s-ui 和 Caddy
# 这里的 /app/s-ui 是原镜像的启动路径，请根据实际镜像微调
CMD ["sh", "-c", "caddy run --config /etc/caddy/Caddyfile --adapter caddyfile & /app/s-ui"]
