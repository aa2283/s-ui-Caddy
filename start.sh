#!/bin/sh

# 1. 启动 s-ui 并完全静音，丢入后台
s-ui run > /dev/null 2>&1 &

# 2. 等待 3 秒确保 s-ui 初始化
sleep 3

# 3. 运行隧道 (这里不加 &，让它占据前台以便我们看日志)
echo "Starting Cloudflare Tunnel..."
/usr/local/bin/cloudflared tunnel --no-autoupdate run --token ${TUNNEL_TOKEN}
