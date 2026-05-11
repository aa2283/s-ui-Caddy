# 1. 依然借用官方镜像的程序
FROM cloudflare/cloudflared:latest as tunnel-builder

# 2. 回到 s-ui
FROM alireza7/s-ui:latest
USER root

# 安装运行环境
RUN apk add --no-cache libc6-compat gcompat ca-certificates

# 拷贝二进制文件
COPY --from=tunnel-builder /usr/local/bin/cloudflared /usr/local/bin/cloudflared

# --- 关键改动在这里 ---
# 我们不再用 CMD，我们改用 ENTRYPOINT，并强行把 cloudflared 跑在最前面
# 这里的逻辑是：先后台启动隧道，再运行 s-ui。这样 s-ui 就算占着控制台，隧道也已经在后台跑起来了。
ENTRYPOINT ["sh", "-c", "/usr/local/bin/cloudflared tunnel --no-autoupdate run --token ${TUNNEL_TOKEN} & /usr/local/bin/s-ui run"]
