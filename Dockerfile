FROM alireza7/s-ui:latest
USER root
RUN apk add --no-cache caddy

# 自动寻找 s-ui 二进制文件并赋予权限
RUN find / -name "s-ui" -exec chmod +x {} + || true

COPY Caddyfile /etc/caddy/Caddyfile
EXPOSE 2095

# 使用 find 直接运行，不管它在哪个目录下
CMD ["sh", "-c", "$(find / -name 's-ui' | head -n 1) run & sleep 10 && caddy run --config /etc/caddy/Caddyfile --adapter caddyfile"]
