FROM alireza7/s-ui:latest

USER root

# 1. 安装 Caddy
RUN apk add --no-cache caddy

# 2. 复制配置文件
COPY Caddyfile /etc/caddy/Caddyfile

# 3. 这里的关键：直接给可能存在的二进制文件加权限
# 如果在 /app 下找不到，就去全局路径找
RUN chmod +x /app/s-ui || chmod +x /usr/local/bin/s-ui || true

EXPOSE 2095

# 4. 启动逻辑：使用更通用的命令启动
# 很多时候直接执行 s-ui 即可，不需要加 /app/ 路径
CMD ["sh", "-c", "s-ui run & sleep 5 && caddy run --config /etc/caddy/Caddyfile --adapter caddyfile"]
