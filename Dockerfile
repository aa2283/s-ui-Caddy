FROM cloudflare/cloudflared:latest as tunnel-builder

FROM alireza7/s-ui:latest
USER root

# 只装最基础的兼容库
RUN apk add --no-cache libc6-compat gcompat ca-certificates

# 拷贝隧道程序
COPY --from=tunnel-builder /usr/local/bin/cloudflared /usr/local/bin/cloudflared

ENV TUNNEL_TOKEN=""

# 💡 绝招：不改入口点，直接把命令写进一个后台进程
# 我们利用 sh 的特性，先在后台启动隧道，再执行原镜像默认的启动脚本
CMD /usr/local/bin/cloudflared tunnel --no-autoupdate run --token ${TUNNEL_TOKEN} & s-ui run
