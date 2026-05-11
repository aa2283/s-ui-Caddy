FROM cloudflare/cloudflared:latest as tunnel-builder

FROM alireza7/s-ui:latest
USER root

RUN apk add --no-cache libc6-compat gcompat ca-certificates

COPY --from=tunnel-builder /usr/local/bin/cloudflared /usr/local/bin/cloudflared

ENV TUNNEL_TOKEN=""

# 这里的逻辑是：
# 1. 启动隧道并丢到后台
# 2. 自动搜索 s-ui 的位置并执行
ENTRYPOINT ["sh", "-c", "/usr/local/bin/cloudflared tunnel --no-autoupdate run --token ${TUNNEL_TOKEN} & $(find / -name s-ui -type f -executable | head -n 1) run"]
