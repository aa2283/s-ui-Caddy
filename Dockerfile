FROM alireza0/s-ui:latest

USER root

# 安装 Caddy
RUN apk add --no-cache caddy

# 复制配置文件
COPY Caddyfile /etc/caddy/Caddyfile

# 暴露端口 (Northflank 需要知道哪个端口对外)
EXPOSE 2095

# 修正后的启动命令：先启动 caddy 放在后台，再启动 s-ui 放在前台
CMD ["sh", "-c", "caddy run --config /etc/caddy/Caddyfile --adapter caddyfile & /app/s-ui"]
