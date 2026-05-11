FROM cloudflare/cloudflared:latest as tunnel-builder

FROM alireza7/s-ui:latest
USER root

# 安装运行库
RUN apk add --no-cache libc6-compat gcompat ca-certificates

# 拷贝隧道程序
COPY --from=tunnel-builder /usr/local/bin/cloudflared /usr/local/bin/cloudflared

# 拷贝启动脚本并赋予最高权限
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENV TUNNEL_TOKEN=""

# 彻底重置 ENTRYPOINT
ENTRYPOINT ["/bin/sh", "/entrypoint.sh"]
