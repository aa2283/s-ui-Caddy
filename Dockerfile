# 第一阶段：从 CF 官方镜像“借”一个现成的、能用的二进制文件
FROM cloudflare/cloudflared:latest as tunnel-builder

# 第二阶段：回到你的 s-ui 镜像
FROM alireza7/s-ui:latest
USER root

# 安装必要的运行库（Alpine 运行外部程序必装）
RUN apk add --no-cache libc6-compat gcompat ca-certificates

# 把刚才“借”来的 cloudflared 放到系统路径下
COPY --from=tunnel-builder /usr/local/bin/cloudflared /usr/local/bin/cloudflared

# 设置变量名（确保和 Northflank 后台一致）
ENV TUNNEL_TOKEN=""

# 核心启动逻辑：
# 1. 启动 s-ui 并丢到后台
# 2. 打印版本（验证程序能不能跑）
# 3. 运行隧道并把所有报错都打印到日志里 (2>&1)
CMD ["sh", "-c", "s-ui run > /dev/null 2>&1 & sleep 3 && /usr/local/bin/cloudflared --version && /usr/local/bin/cloudflared tunnel --no-autoupdate run --token ${TUNNEL_TOKEN} 2>&1"]
