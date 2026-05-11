FROM cloudflare/cloudflared:latest as tunnel-builder

FROM alireza7/s-ui:latest
USER root

RUN apk add --no-cache libc6-compat gcompat ca-certificates

COPY --from=tunnel-builder /usr/local/bin/cloudflared /usr/local/bin/cloudflared

# 拷贝启动脚本并赋予执行权限
COPY start.sh /start.sh
RUN chmod +x /start.sh

ENV TUNNEL_TOKEN=""

# 使用脚本启动
CMD ["/bin/sh", "/start.sh"]
